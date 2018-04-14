(* Code generation: translate takes a semantically checked AST and
produces LLVM IR

LLVM tutorial: Make sure to read the OCaml version of the tutorial

http://llvm.org/docs/tutorial/index.html

Detailed documentation on the OCaml LLVM library:

http://llvm.moe/
http://llvm.moe/ocaml/

*)

(* We'll refer to Llvm and Ast constructs with module names *)
module L = Llvm
module A = Ast
open Sast 

module StringMap = Map.Make(String)

(* Code Generation from the SAST. Returns an LLVM module if successful,
   throws an exception if something is wrong. *)
let translate (globals, functions) compiling_builtin =
  let context    = L.global_context () in
  (* Add types to the context so we can use them in our LLVM code *)
  let i32_t      = L.i32_type    context
  and i8_t       = L.i8_type     context 
  and i1_t       = L.i1_type     context
  and float_t    = L.double_type context
  and void_t     = L.void_type   context
  
  (* Create an LLVM module -- this is a "container" into which we'll 
     generate actual code *)
  and the_module = L.create_module context "MicroC" in

  let ip_t       = L.pointer_type i8_t in
  let ip32_t       = L.pointer_type i32_t in
  let struct_t   = L.struct_type context [|i32_t; i32_t; i32_t; ip32_t|] in
  let structp_t  = L.pointer_type struct_t in
  let fstruct_t  = L.struct_type context [|i32_t; L.pointer_type structp_t|] in

  (* Convert MicroC types to LLVM types *)
  let ltype_of_typ = function
      A.Int   -> i32_t
    | A.Bool  -> i1_t
    | A.Float -> float_t
    | A.Void  -> void_t
    | A.Arr   -> structp_t
    | A.String -> ip_t
    | A.Kernel -> L.pointer_type fstruct_t
    (* | t -> raise (Failure ("Type " ^ A.string_of_typ t ^ " not implemented yet")) *)
  in

  let init t = match t with 
            A.Arr -> L.const_pointer_null structp_t
          | A.String -> L.const_pointer_null ip_t
          | _     -> L.const_int (ltype_of_typ t) 0
  in
  let i32_zero = init A.Int in
  
  let g_var_suffix = if compiling_builtin then "_bn" else "" in

  let get_optional opt = match opt with
    Some x -> x
  | _ -> raise (Failure ("Failed to get optional")) in 

  let global_vars = 
    let global_var m (t, n) = StringMap.add n (L.define_global (n ^ g_var_suffix) (init t) the_module) m in
    List.fold_left global_var StringMap.empty globals in

  (* Declare a "printf" function to implement MicroC's "print". *)
  let printf_t : L.lltype = 
      L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func : L.llvalue = 
     L.declare_function "printf" printf_t the_module in 

  let loadimg_t = L.function_type structp_t [| ip_t |] in
  let loadimg_func = L.declare_function "load" loadimg_t the_module in

  let closeimg_t = L.function_type i32_t [| structp_t; i32_t |] in
  let closeimg_func = L.declare_function "close" closeimg_t the_module in

  let saveimg_t = L.function_type i32_t [| structp_t; ip_t |] in
  let saveimg_func = L.declare_function "save" saveimg_t the_module in

  let trans_t = L.function_type structp_t [| structp_t |] in
  let expf_t = L.function_type float_t [| float_t ; i32_t |] in
  let exp_t = L.function_type i32_t [| i32_t; i32_t |] in
  let mtimes_t = L.function_type structp_t [| structp_t; structp_t |] in 
  let scifi_t = L.function_type i32_t [| structp_t |] in
  let apply_conv_filter_t = L.function_type i32_t [| structp_t; structp_t |] in
  let apply_conv_filters_t = L.function_type i32_t [| structp_t; L.pointer_type fstruct_t |] in

  let (trans_func, expf_func, exp_func, mtimes_func, apply_conv_filter_func, apply_conv_filters_func, scifi_func) = 
  if compiling_builtin 
    then (printf_func, printf_func, printf_func, printf_func, printf_func, printf_func, printf_func)
    else (L.declare_function "trans" trans_t the_module, L.declare_function "expf" expf_t the_module, 
          L.declare_function "exp" exp_t the_module, L.declare_function "mtimes" mtimes_t the_module,
          L.declare_function "apply_conv_filter" apply_conv_filter_t the_module,
          L.declare_function "apply_conv_filters" apply_conv_filters_t the_module, 
          L.declare_function "scifi_filter" scifi_t the_module) 
  
  in

  let to_imp str = raise (Failure ("Not yet implemented: " ^ str)) in

  let function_decls =
    let function_decl m fdecl =
      let name = fdecl.sfname
      and formal_types = 
  Array.of_list (List.map (fun (t, _) -> ltype_of_typ t) fdecl.sformals)
      in let ftype = L.function_type (ltype_of_typ fdecl.styp) formal_types in
      StringMap.add name (L.define_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty functions in

  (* Generate the instructions for a trivial "main" function *)
  let build_function fdecl =
    (* Make the LLVM module "aware" of the main function *)
    let (the_function, _) = StringMap.find fdecl.sfname function_decls in
    (* Create an Instruction Builder, which points into a basic block
      and determines where the next instruction should be placed *)
    let builder = L.builder_at_end context (L.entry_block the_function) in
    (* Create a pointer to a format string for printf *)
    let int_format_str = L.build_global_stringptr "%d\n" "fmt" builder
    and float_format_str = L.build_global_stringptr "%g\n" "fmt" builder
    and string_format_str = L.build_global_stringptr "%s\n" "fmt" builder in
    let add_local (m, tmp_builder) (t, n) = 
      let local_var = L.build_alloca (ltype_of_typ t) n tmp_builder
      in (StringMap.add n local_var m, tmp_builder)
          in
    let local_vars =
      let add_formal m (t, n) p =
        let () = L.set_value_name n p in
  let local = L.build_alloca (ltype_of_typ t) n builder in
        let _ = L.build_store p local builder in
  StringMap.add n local m
      in


      let formals = List.fold_left2 add_formal StringMap.empty fdecl.sformals
          (Array.to_list (L.params the_function)) in
      List.fold_left add_local (formals, builder) fdecl.slocals
    in

    let scoped_vars = [fst local_vars; global_vars] in

    let rec lookup n var_list = match var_list with 
                           hd::tl -> (try StringMap.find n hd with Not_found -> lookup n tl)
                         | [hd] -> StringMap.find n hd
                         | _ -> raise (Failure("wrong variable tables"))
    in

    (* Generate LLVM code for a call to MicroC's "print" *)
    let rec expr builder ((tp, e) : sexpr) symbol_table = match e with
  SLiteral i -> L.const_int i32_t i (* Generate a constant integer *)
      | SBoolLit b -> L.const_int i1_t (if b then 1 else 0)
      | SSlit s -> L.build_global_stringptr s ".str" builder
      | SFliteral l -> L.const_float_of_string float_t l
      | SNoexpr -> L.const_int i32_t 0
      | SNoassign -> init tp
      | SFilter s -> L.const_string context s 
      | SFilterliteral s -> 
      let to_array x = expr builder x symbol_table
       in let f _ = L.const_pointer_null structp_t
       in let m1 = List.map to_array s 
       in let img_array = L.const_array structp_t (Array.of_list (List.map f s))
       in let ipt = L.define_global ("tmp" ^ g_var_suffix) img_array the_module
       in let f2 idx val' = (L.build_store val' (L.build_in_bounds_gep ipt [|L.const_int i32_t 0;L.const_int i32_t idx|] "tmp" builder) builder)
       in let _ = List.mapi f2 m1
       in let img_array_ptr = L.build_pointercast ipt (L.pointer_type structp_t) ("tmp" ^ g_var_suffix) builder
       in let const_arr = (L.const_struct context [| L.const_int i32_t (List.length s); img_array_ptr |]  )
       in let global_arr = L.define_global ("tmp" ^ g_var_suffix) const_arr the_module 
       in global_arr
      | SId s -> L.build_load (lookup s symbol_table) s builder
      | SArrliteral s -> 
      let to_array x = expr builder x symbol_table
       in let f _ = L.const_int i32_t 0
       in let m1 = List.map to_array s 
       in let img_array = L.const_array i32_t (Array.of_list (List.map f s))
       in let i32t = L.define_global ("tmp" ^ g_var_suffix) img_array the_module
       in let f2 idx val' = (L.build_store val' (L.build_in_bounds_gep i32t [|L.const_int i32_t 0;L.const_int i32_t idx|] "tmp" builder) builder)
       in let _ = List.mapi f2 m1
       in let img_array_ptr = L.build_pointercast i32t ip32_t ("tmp" ^ g_var_suffix) builder
       in let const_arr = (L.const_struct context [| L.const_int i32_t (List.length s); L.const_int i32_t 0; L.const_int i32_t 0; img_array_ptr |]  )
       in let global_arr = L.define_global ("tmp" ^ g_var_suffix) const_arr the_module 
       in global_arr
      | SArrsub (e, sexpr_list) -> let expr_builder = expr builder e symbol_table in
        let w = let expr_builder2 = L.build_struct_gep expr_builder 2 "tmp" builder in L.build_load expr_builder2 "tmp" builder in
        let h = let expr_builder2 = L.build_struct_gep expr_builder 1 "tmp" builder in L.build_load expr_builder2 "tmp" builder in
        let wh = L.build_mul w h "tmp" builder in
        let l2 = 
          match sexpr_list with
              [e1] -> expr builder e1 symbol_table
            | [e1;e2] -> let e1' = expr builder e1 symbol_table and e2' = expr builder e2 symbol_table in (L.build_add (L.build_mul e1' w "tmp" builder) e2' "tmp" builder)
            | [e1;e2;e3] -> let e1' = expr builder e1 symbol_table and e2' = expr builder e2 symbol_table and e3' = expr builder e3 symbol_table in 
              L.build_add (L.build_mul e1' wh "tmp" builder) (L.build_add (L.build_mul e2' w "tmp" builder) e3' "tmp" builder) "tmp" builder
            | _ -> raise (Failure ("Not yet supported for this multi-dimensional array type"))

        in
        let arr_builder = L.build_struct_gep expr_builder 3 "tmp" builder in
        let abxd = L.build_load arr_builder "tmp" builder in
        let abxd = L.build_in_bounds_gep abxd [|l2|] "tmp" builder in
        let abxd = L.build_load abxd "tmp" builder in abxd
      | SArrAssign (e1, e_rhs) -> (
          let expr_rhs = expr builder e_rhs symbol_table in
          let expr_rhs = L.build_intcast expr_rhs i32_t "tmp" builder in
          let (_, sx) = e1 in match sx with 
               SArrsub(e, sexpr_list) -> 
                  let expr_builder = expr builder e symbol_table in
                  let w = let expr_builder2 = L.build_struct_gep expr_builder 2 "tmp" builder in L.build_load expr_builder2 "tmp" builder in
                  let h = let expr_builder2 = L.build_struct_gep expr_builder 1 "tmp" builder in L.build_load expr_builder2 "tmp" builder in
                  let wh = L.build_mul w h "tmp" builder in 
                  let l2 = 
                    match sexpr_list with
                        [e1] -> expr builder e1 symbol_table
                      | [e1;e2] -> let e1' = expr builder e1 symbol_table and e2' = expr builder e2 symbol_table in (L.build_add (L.build_mul e1' w "tmp" builder) e2' "tmp" builder)
                      | [e1;e2;e3] -> let e1' = expr builder e1 symbol_table and e2' = expr builder e2 symbol_table and e3' = expr builder e3 symbol_table in
                        L.build_add (L.build_mul e1' wh "tmp" builder) (L.build_add (L.build_mul e2' w "tmp" builder) e3' "tmp" builder) "tmp" builder
                      | _ -> raise (Failure ("Not yet supported for this multi-dimensional array type"))
                  in
                  let arr_builder = L.build_struct_gep expr_builder 3 "tmp" builder in
                  let abxd = L.build_load arr_builder "tmp" builder in
                  let abxd = L.build_in_bounds_gep abxd [|l2|] "tmp" builder in
                  let _ = L.build_store expr_rhs abxd builder
                  in expr_rhs
             | _ -> raise (Failure ("LHS should be an array subscript!"))
           )
      | SBinop (e1, op, e2) ->
    let (t, _) = e1
    and e1' = expr builder e1 symbol_table
    and e2' = expr builder e2 symbol_table in
    if t = A.Float then (match op with
      A.Add     -> L.build_fadd e1' e2' "tmp" builder
    | A.Sub     -> L.build_fsub e1' e2' "tmp" builder
    | A.Mult    -> L.build_fmul e1' e2' "tmp" builder
    | A.Div     -> L.build_fdiv e1' e2' "tmp" builder
    | A.Equal   -> L.build_fcmp L.Fcmp.Oeq e1' e2' "tmp" builder
    | A.Neq     -> L.build_fcmp L.Fcmp.One e1' e2' "tmp" builder
    | A.Less    -> L.build_fcmp L.Fcmp.Olt e1' e2' "tmp" builder
    | A.Leq     -> L.build_fcmp L.Fcmp.Ole e1' e2' "tmp" builder
    | A.Greater -> L.build_fcmp L.Fcmp.Ogt e1' e2' "tmp" builder
    | A.Geq     -> L.build_fcmp L.Fcmp.Oge e1' e2' "tmp" builder
    | A.Expo    -> L.build_call expf_func [|e1';e2'|] "expf" builder
    | A.And | A.Or | A.Mtimes | A.At ->
        raise (Failure "internal error: semant should have rejected and/or on float")
    )
    else if (t = A.Int || t = A.Bool) then (match op with
      A.Add     -> L.build_add e1' e2' "tmp" builder
    | A.Sub     -> L.build_sub e1' e2' "tmp" builder
    | A.Mult    -> L.build_mul e1' e2' "tmp" builder
    | A.Div     -> L.build_sdiv e1' e2' "tmp" builder
    | A.And     -> L.build_and e1' e2' "tmp" builder
    | A.Or      -> L.build_or e1' e2' "tmp" builder
    | A.Equal   -> L.build_icmp L.Icmp.Eq e1' e2' "tmp" builder
    | A.Neq     -> L.build_icmp L.Icmp.Ne e1' e2' "tmp" builder
    | A.Less    -> L.build_icmp L.Icmp.Slt e1' e2' "tmp" builder
    | A.Leq     -> L.build_icmp L.Icmp.Sle e1' e2' "tmp" builder
    | A.Greater -> L.build_icmp L.Icmp.Sgt e1' e2' "tmp" builder
    | A.Geq     -> L.build_icmp L.Icmp.Sge e1' e2' "tmp" builder
    | A.Expo    -> L.build_call exp_func [|e1';e2'|] "exp" builder
    | A.Mtimes | A.At -> raise (Failure "internal error: semant should have rejected and/or on int")
    )
  else (match op with
      A.Mtimes -> L.build_call mtimes_func [|e1';e2'|] "mtimes" builder
    | A.At -> L.build_call apply_conv_filters_func [| e2'; e1'|] "apply_conv_filters" builder(*let load_val idx = L.build_load (L.build_in_bounds_gep e1' [| L.const_int i32_t 0;  L.const_int i32_t idx |] "tmp" builder) "tmp" builder in let len_lvalue = load_val 0 in let len = get_optional (L.int64_of_const len_lvalue)
        in let len = Int64.to_int len in let () =  print_int(len) in 
        let conv_helper idx = L.build_call apply_conv_filter_func [| e2'; load_val idx |] "apply_conv_filter" builder in
        conv_helper 1*)
    (*| A.At ->  let get_vec idx = L.const_extractelement e1' (L.const_int i32_t idx) in let len_lvalue = get_vec 0 in let len = get_optional (L.int64_of_const len_lvalue)
        in let len = Int64.to_int len in let get_string idx = get_optional (L.string_of_const (get_vec idx)) 
        in let fhelper idx = expr builder (A.Void, SCall((get_string idx) ^ "_filter", [e2])) symbol_table in let rec apply_filter q = (if q = 1 then fhelper q else (let _ = apply_filter (q - 1) in fhelper q)) in apply_filter len*)
    | _ -> raise (Failure "not implemented yet")
    )
      | SUnop(op, e) ->
    let (t, _) = e and e' = expr builder e symbol_table in
    (match op with
      A.Neg when t = A.Float -> L.build_fneg e' "tmp" builder
    | A.Neg              -> L.build_neg e' "tmp" builder
    | A.Not              -> L.build_not e' "tmp" builder
    | A.Trans when t = A.Arr -> let _ = L.build_call trans_func [|e'|] "trans" builder in e'
    | A.Trans -> raise (Failure "internal error: can't perform matrix operation on scalar")) 
      | SAssign (s, e) -> let e' = expr builder e symbol_table in
                          let e'  = (match e with 
                              (_, SArrsub(_, _)) -> L.build_intcast e' i32_t "tmp" builder
                            | _ -> e')
                        in let _ = L.build_store e' (lookup s symbol_table) builder in e'
      | SCall ("print", [e]) -> (* Generate a call instruction *)
    L.build_call printf_func [| int_format_str ; (expr builder e symbol_table) |]
      "printf" builder 
      (* Throw an error for any other expressions *)
      | SCall ("printf", [e]) ->
    L.build_call printf_func [| float_format_str ; (expr builder e symbol_table) |]
      "printf" builder
      | SCall ("set_hw",[e1;e2;e3]) -> let e1' = expr builder e1 symbol_table and e2' = expr builder e2 symbol_table and e3' = expr builder e3 symbol_table in
        let e4' = L.build_struct_gep e1' 1 ("tmp" ^ g_var_suffix) builder in
        let _ = L.build_store e2' e4' builder in
        let e5' = L.build_struct_gep e1' 2 ("tmp" ^ g_var_suffix) builder in
        let _ = L.build_store e3' e5' builder in e1'
      | SCall ("length", [e]) -> let expr_builder = expr builder e symbol_table in 
        let expr_builder = L.build_struct_gep expr_builder 0 ("tmp" ^ g_var_suffix) builder in
        let len = L.build_load expr_builder ("tmp" ^ g_var_suffix) builder in len
      | SCall ("height", [e]) -> let expr_builder = expr builder e symbol_table in 
        let expr_builder = L.build_struct_gep expr_builder 1 ("tmp" ^ g_var_suffix) builder in
        let len = L.build_load expr_builder ("tmp" ^ g_var_suffix) builder in len
      | SCall ("width", [e]) -> let expr_builder = expr builder e symbol_table in 
        let expr_builder = L.build_struct_gep expr_builder 2 ("tmp" ^ g_var_suffix) builder in
        let len = L.build_load expr_builder ("tmp" ^ g_var_suffix) builder in len
      | SCall ("f_len", [e]) -> let expr_builder = expr builder e symbol_table in 
        let expr_builder = L.build_struct_gep expr_builder 0 ("tmp" ^ g_var_suffix) builder in
        let len = L.build_load expr_builder ("tmp" ^ g_var_suffix) builder in len
      | SCall ("get_filter", [e1; e2]) -> let expr_builder = expr builder e1 symbol_table in 
        let arr_builder = L.build_struct_gep expr_builder 1 "tmp" builder in
        let abxd = L.build_load arr_builder "tmp" builder in
        let abxd = L.build_in_bounds_gep abxd [|expr builder e2 symbol_table|] "tmp" builder in
        let abxd = L.build_load abxd "tmp" builder in abxd
      | SCall("float_of", [e]) -> let e' = expr builder e symbol_table in L.build_sitofp e' float_t ("tmp" ^ g_var_suffix) builder
      | SCall("int_of", [e]) -> let e' = expr builder e symbol_table in L.build_fptosi e' i32_t ("tmp" ^ g_var_suffix) builder
      | SCall ("init", [e2; e3; e4]) -> let e2' = expr builder e2 symbol_table in let e3' = expr builder e3 symbol_table in let e4' = expr builder e4 symbol_table
        in let mptr = L.build_array_malloc i32_t e2' ("tmp" ^ g_var_suffix) builder 
        in let empty_ptr = L.const_pointer_null ip32_t

        in let init_struct = L.const_struct context [|i32_zero; i32_zero; i32_zero; empty_ptr|]
        in let e1' = L.define_global ("init_arr" ^ g_var_suffix) init_struct the_module
        in let e5'' = L.build_struct_gep e1' 0 ("tmp" ^ g_var_suffix) builder
        in let _ = L.build_store e2' e5'' builder
        in let e6'' = L.build_struct_gep e1' 1 ("tmp" ^ g_var_suffix) builder
        in let _ = L.build_store e3' e6'' builder
        in let e7'' = L.build_struct_gep e1' 2 ("tmp" ^ g_var_suffix) builder
        in let _ = L.build_store e4' e7'' builder
        in let e8'' = L.build_struct_gep e1' 3 ("tmp" ^ g_var_suffix) builder
        in let _ = L.build_store mptr e8'' builder in e1'
      | SCall ("imgcpy", [e1;e2]) -> let e1' = expr builder e1 symbol_table in let e2' = expr builder e2 symbol_table in
        let e1_l = L.build_struct_gep e1' 0 ("tmp" ^ g_var_suffix) builder in
        let e1_h = L.build_struct_gep e1' 1 ("tmp" ^ g_var_suffix) builder in
        let e1_w = L.build_struct_gep e1' 2 ("tmp" ^ g_var_suffix) builder in
        let e1_img = L.build_struct_gep e1' 3 ("tmp" ^ g_var_suffix) builder in
        let e2_l = L.build_load (L.build_struct_gep e2' 0 ("tmp" ^ g_var_suffix) builder) "tmp_len" builder in
        let e2_h = L.build_load (L.build_struct_gep e2' 1 ("tmp" ^ g_var_suffix) builder) "tmp_h" builder in
        let e2_w = L.build_load (L.build_struct_gep e2' 2 ("tmp" ^ g_var_suffix) builder) "tmp_w" builder in
        let e2_img = L.build_load (L.build_struct_gep e2' 3 ("tmp" ^ g_var_suffix) builder) "tmp_img" builder in
        let _ = L.build_store e2_l e1_l builder in
        let _ = L.build_store e2_h e1_h builder in
        let _ = L.build_store e2_w e1_w builder in
        let _ = L.build_store e2_img e1_img builder in
        e1'
      | SCall ("printline", [e]) -> 
    L.build_call printf_func [| string_format_str ; (expr builder e symbol_table) |]
      "printf" builder
      | SCall ("scifi_filter", [e]) ->
    L.build_call scifi_func [| (expr builder e symbol_table) |] "scifi_filter" builder
      | SCall ("apply_conv_filter", [e1; e2]) ->
    L.build_call apply_conv_filter_func [| (expr builder e1 symbol_table); (expr builder e2 symbol_table) |] "apply_conv_filter" builder
      | SCall("load", [e]) ->
    L.build_call loadimg_func [| (expr builder e symbol_table) |] "load" builder
      | SCall("close", [e; e2]) ->
    L.build_call closeimg_func [| (expr builder e symbol_table); (expr builder e2 symbol_table) |] "close" builder
      | SCall("save", [e1; e2]) ->
    L.build_call saveimg_func [| (expr builder e1 symbol_table); (expr builder e2 symbol_table) |] "save" builder
      | SCall (f, act) ->
         let (fdef, fdecl) = StringMap.find f function_decls in
    let temp_helper b st x = expr b x st in 
    let actuals = List.rev (List.map (temp_helper builder symbol_table) (List.rev act)) in
    let result = (match fdecl.styp with
                         A.Void -> ""
                       | _ -> f ^ "_result") in
          L.build_call fdef (Array.of_list actuals) result builder
      (* | _ -> to_imp (string_of_sexpr (A.Int,e))  *)
    in
    (* Deal with a block of expression statements, terminated by a return *)
    let add_terminal builder f =
      match L.block_terminator (L.insertion_block builder) with
  Some _ -> ()
      | None -> ignore (f builder) in

    let rec stmt (builder,symbol_table) = function
  SBlock sl -> List.fold_left stmt (builder, symbol_table) sl
      | SExpr e -> let _ = expr builder e symbol_table in (builder, symbol_table) 
      | SVar (e1, e2) -> let (tp, s) = e1 in let (symbol_table2, _) = add_local (List.hd symbol_table, builder) (tp, s) in
                                              let symbol_table3 = (symbol_table2 :: (List.tl symbol_table)) in
                                                (*let _ = expr builder (tp, SId(s)) symbol_table3 in *)
                                          let _ = match e2 with
                                              (Void, SNoassign) -> init tp
                                            | _ -> expr builder (tp, SAssign(s, e2)) symbol_table3
           in (builder, symbol_table3)
      | SReturn e -> let _ = match fdecl.styp with
                              A.Int -> L.build_ret (expr builder e symbol_table) builder 
                            | A.Arr -> L.build_ret (expr builder e symbol_table) builder
                            | A.Float -> L.build_ret (expr builder e symbol_table) builder
                            | _ -> to_imp (A.string_of_typ fdecl.styp)
                     in (builder, symbol_table)
      | SIf (predicate, then_stmt, else_stmt) ->
         let bool_val = expr builder predicate symbol_table in
   let merge_bb = L.append_block context "merge" the_function in
         let branch_instr = L.build_br merge_bb in
   let then_bb = L.append_block context "then" the_function in
         let then_builder = fst (stmt ((L.builder_at_end context then_bb), symbol_table) then_stmt) in 
   let () = add_terminal then_builder branch_instr in

   let else_bb = L.append_block context "else" the_function in
         let else_builder = fst (stmt ((L.builder_at_end context else_bb), symbol_table) else_stmt) in
   let () = add_terminal else_builder branch_instr in

   let _ = L.build_cond_br bool_val then_bb else_bb builder in

   (L.builder_at_end context merge_bb, symbol_table)

      | SWhile (predicate, body) ->
   let pred_bb = L.append_block context "while" the_function in
   let _ = L.build_br pred_bb builder in
   let body_bb = L.append_block context "while_body" the_function in
         let while_builder = fst (stmt ((L.builder_at_end context body_bb), symbol_table) body) in
   let () = add_terminal while_builder (L.build_br pred_bb) in
   let pred_builder = L.builder_at_end context pred_bb in
   let bool_val = expr pred_builder predicate symbol_table in
   let merge_bb = L.append_block context "merge" the_function in
   let _ = L.build_cond_br bool_val body_bb merge_bb pred_builder in
   (L.builder_at_end context merge_bb, symbol_table)

      | SFor (e1, e2, e3, body) -> stmt (builder, symbol_table)
      ( SBlock [SExpr e1 ; SWhile (e2, SBlock [body ; SExpr e3]) ] ) 
      (* | s -> to_imp (string_of_sstmt s) *)
    (* Generate the instructions for the function's body, 
       which mutates the_module *)
    in

    let builder = fst (stmt (builder, scoped_vars) (SBlock fdecl.sbody)) in

    add_terminal builder (match fdecl.styp with
        A.Void -> L.build_ret_void
        | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))
    
    in
  (* Build each function (there should only be one for Hello World), 
     and return the final module *)
    List.iter build_function functions; the_module
