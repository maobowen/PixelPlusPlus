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
let translate (globals, functions) =
  let context    = L.global_context () in
  (* Add types to the context so we can use them in our LLVM code *)
  let i32_t      = L.i32_type    context
  and i64_t      = L.i64_type    context
  and i8_t       = L.i8_type     context 
  and i1_t       = L.i1_type     context
  and float_t    = L.double_type context
  and void_t     = L.void_type   context
  
  (* Create an LLVM module -- this is a "container" into which we'll 
     generate actual code *)
  and the_module = L.create_module context "MicroC" in

  let ip_t       = L.pointer_type i8_t in
  let ipp_t      = L.pointer_type ip_t
  and ip32_t     = L.pointer_type i32_t in
  let struct_t   = L.struct_type context [|i32_t; i32_t; i32_t; ip_t|] in
  let structp_t  = L.pointer_type struct_t                  in

  (* Convert MicroC types to LLVM types *)
  let ltype_of_typ = function
      A.Int   -> i32_t
    | A.Bool  -> i1_t
    | A.Float -> float_t
    | A.Void  -> void_t
    | A.Arr   -> structp_t
    | A.String -> ip_t
    | t -> raise (Failure ("Type " ^ A.string_of_typ t ^ " not implemented yet"))
  in

  let global_vars = 
    let global_var m (t, n) = 
      let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m in
    List.fold_left global_var StringMap.empty globals in

  (* Declare a "printf" function to implement MicroC's "print". *)
  let printf_t : L.lltype = 
      L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func : L.llvalue = 
     L.declare_function "printf" printf_t the_module in 

  let loadimg_t = L.function_type structp_t [| ip_t |] in
  let loadimg_func = L.declare_function "load" loadimg_t the_module in

  let closeimg_t = L.function_type i32_t [| structp_t |] in
  let closeimg_func = L.declare_function "close" closeimg_t the_module in

  let saveimg_t = L.function_type i32_t [| structp_t; ip_t |] in
  let saveimg_func = L.declare_function "save" saveimg_t the_module in

  let length_t = L.function_type i32_t [| structp_t |] in
  let length_func = L.declare_function "length" length_t the_module in

  let width_t = L.function_type i32_t [| structp_t |] in
  let width_func = L.declare_function "width" width_t the_module in

  let height_t = L.function_type i32_t [| structp_t |] in
  let height_func = L.declare_function "height" width_t the_module in

  let init_t = L.function_type i32_t [| structp_t; i32_t; i32_t; i32_t |] in
  let init_func = L.declare_function "init" init_t the_module in

  let addPixel_t = L.function_type i32_t [| structp_t |] in
  let length_func = L.declare_function "addPixel" addPixel_t the_module in

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
    let init_list _ = "%d" in
    let create_fmt_str len = "[" ^ (String.concat "," (List.init len init_list)) ^ "]\n" in
    (* Create a pointer to a format string for printf *)
    let int_format_str = L.build_global_stringptr "%d\n" "fmt" builder
    and float_format_str = L.build_global_stringptr "%g\n" "fmt" builder
    and string_format_str = L.build_global_stringptr "%s\n" "fmt" builder
    and arr_format_str len = L.build_global_stringptr (create_fmt_str len) "fmt" builder in

    let local_vars =
      let add_formal m (t, n) p =
        let () = L.set_value_name n p in
  let local = L.build_alloca (ltype_of_typ t) n builder in
        let _ = L.build_store p local builder in
  StringMap.add n local m
      in

      let add_local m (t, n) = 
  let local_var = L.build_alloca (ltype_of_typ t) n builder
  in StringMap.add n local_var m
      in

      let formals = List.fold_left2 add_formal StringMap.empty fdecl.sformals
          (Array.to_list (L.params the_function)) in
      List.fold_left add_local formals fdecl.slocals
    in


    let lookup n = try StringMap.find n local_vars
                   with Not_found -> StringMap.find n global_vars
    in

    (* Generate LLVM code for a call to MicroC's "print" *)
    let rec expr builder ((_, e) : sexpr) = match e with
  SLiteral i -> L.const_int i32_t i (* Generate a constant integer *)
      | SBoolLit b -> L.const_int i1_t (if b then 1 else 0)
      | SSlit s -> L.build_global_stringptr s ".str" builder
      | SFliteral l -> L.const_float_of_string float_t l
      | SNoexpr -> L.const_int i32_t 0
      | SId s -> L.build_load (lookup s) s builder
      | SArrliteral s -> 
      let to_array x = let y = snd x in match y with
       SLiteral i2 -> L.const_int i8_t i2
       in let img_array = L.const_array i8_t (Array.of_list (List.map to_array s))
       in let ipt = L.define_global "tmp" img_array the_module
       in let img_array_ptr = L.build_pointercast ipt ip_t "tmp" builder
       in let const_arr = (L.const_struct context [|L.const_int i32_t (List.length s); L.const_int i32_t 0; L.const_int i32_t 0; img_array_ptr|]  )
       in let global_arr = L.define_global "tmp" const_arr the_module 
       in global_arr(*L.build_struct_gep global_arr 0 "tmp" builder*)
      | SArrsub (e, l) -> let expr_builder = expr builder e in let l2 = expr builder l in
        let arr_builder = L.build_struct_gep expr_builder 3 "tmp" builder in
        let abxd = L.build_load arr_builder "tmp" builder in
        let abxd = L.build_in_bounds_gep abxd [|l2|] "tmp" builder in
        L.build_load abxd "tmp" builder
      (*| SArrAssign (e1, e2) -> (
          match e1 with (_, SArrsub(e, l)) ->
          let expr_builder = expr builder e in let l2 = expr builder l in
          let arr_builder = L.build_struct_gep expr_builder 3 "tmp" builder in
          let abxd = L.build_load arr_builder "tmp" builder in 
          let abxd = L.build_in_bounds_gep abxd [|l2|] "tmp" builder in
          let expr_builder2 = expr builder e2 in
          let expr_builder2 = L.build_intcast expr_builder2 i8_t "tmp" builder in
          let _ = L.build_store expr_builder2 abxd builder in expr_builder2 )*)
      | SBinop (e1, op, e2) ->
    let (t, _) = e1
    and e1' = expr builder e1
    and e2' = expr builder e2 in
    if t = A.Float then (match op with
      A.Add     -> L.build_fadd
    | A.Sub     -> L.build_fsub
    | A.Mult    -> L.build_fmul
    | A.Div     -> L.build_fdiv
    | A.Equal   -> L.build_fcmp L.Fcmp.Oeq
    | A.Neq     -> L.build_fcmp L.Fcmp.One
    | A.Less    -> L.build_fcmp L.Fcmp.Olt
    | A.Leq     -> L.build_fcmp L.Fcmp.Ole
    | A.Greater -> L.build_fcmp L.Fcmp.Ogt
    | A.Geq     -> L.build_fcmp L.Fcmp.Oge 
    | A.And | A.Or ->
        raise (Failure "internal error: semant should have rejected and/or on float")
    ) e1' e2' "tmp" builder
    else (match op with
      A.Add     -> L.build_add
    | A.Sub     -> L.build_sub
    | A.Mult    -> L.build_mul
    | A.Div     -> L.build_sdiv
    | A.And     -> L.build_and
    | A.Or      -> L.build_or
    | A.Equal   -> L.build_icmp L.Icmp.Eq
    | A.Neq     -> L.build_icmp L.Icmp.Ne
    | A.Less    -> L.build_icmp L.Icmp.Slt
    | A.Leq     -> L.build_icmp L.Icmp.Sle
    | A.Greater -> L.build_icmp L.Icmp.Sgt
    | A.Geq     -> L.build_icmp L.Icmp.Sge
    ) e1' e2' "tmp" builder
      | SUnop(op, e) ->
    let (t, _) = e and e' = expr builder e in
    (match op with
      A.Neg when t = A.Float -> L.build_fneg
    | A.Neg              -> L.build_neg
    | A.Not              -> L.build_not) e' "tmp" builder
      | SAssign (s, e) ->   (let e' = expr builder e in
                (*match L.type_of e' with
                  structp_t -> let arr_builder = L.build_struct_gep expr_builder 3 "tmp" builder in
                               let abxd = L.build_load arr_builder "tmp" builder in
                               let abxd = L.array_type i8_t 
                               let abxd = L.build_in_bounds_gep abxd [|l2|] "tmp" builder in
                               L.build_load abxd "tmp" builder
                | _         ->*) let _  = L.build_store e' (lookup s) builder in e' )
      | SCall ("print", [e]) -> (* Generate a call instruction *)
    L.build_call printf_func [| int_format_str ; (expr builder e) |]
      "printf" builder 
      (* Throw an error for any other expressions *)
      | SCall ("printf", [e]) ->
    L.build_call printf_func [| float_format_str ; (expr builder e) |]
      "printf" builder
      | SCall ("length", [e]) -> let expr_builder = expr builder e in 
        let expr_builder = L.build_struct_gep expr_builder 0 "tmp" builder in
        let len = L.build_load expr_builder "tmp" builder in
        let () = print_endline(L.string_of_llvalue len) in len
      | SCall ("height", [e]) -> let expr_builder = expr builder e in 
        let expr_builder = L.build_struct_gep expr_builder 1 "tmp" builder in
        let len = L.build_load expr_builder "tmp" builder in len
      | SCall ("width", [e]) -> let expr_builder = expr builder e in 
        let expr_builder = L.build_struct_gep expr_builder 2 "tmp" builder in
        let len = L.build_load expr_builder "tmp" builder in len
      | SCall ("init", [e1; e2; e3; e4]) -> let e2' = expr builder e2 in let e3' = expr builder e3 in let e4' = expr builder e4
        (*in let () = L.set_global_constant true e2'*)
        in let int64_val = L.int64_of_const e2'
        in let int64_v = match int64_val with Some k -> k
        in let len = (Int64.to_int int64_v)
        in let f_helper _ = L.const_int i8_t 0 
        in let img_array = L.const_array i8_t (Array.init len f_helper) 
        in let ipt = L.define_global "tmp" img_array the_module
        in let img_array_ptr = L.build_pointercast ipt ip_t "tmp" builder
        in let const_arr = (L.const_struct context [|e2'; e3'; e4'; img_array_ptr|]  )
        in let global_arr = L.define_global "tmp" const_arr the_module 
        in let (_, e1') = e1 in let e1'' = lookup (match e1' with SId(s) -> s )
        in let _ = L.build_store global_arr e1'' builder in global_arr
      | SCall ("printline", [e]) -> 
    L.build_call printf_func [| string_format_str ; (expr builder e) |]
      "printf" builder
      | SCall ("addPixel", [e]) ->
        let expr_builder = expr builder e in 
        let arr_builder = L.build_struct_gep expr_builder 3 "tmp" builder in
        let abxd_p = L.build_load arr_builder "tmp" builder in 
        let abxd = L.build_in_bounds_gep abxd_p [|L.const_int i32_t (0)|] "tmp" builder in
        let p_val = L.build_load abxd "tmp" builder in
        let n_val = L.build_add p_val (L.const_int i8_t 20) "tmp" builder in
        L.build_store n_val abxd builder 
      | SCall("load", [e]) ->
    L.build_call loadimg_func [| (expr builder e) |] "load" builder
      | SCall("close", [e]) ->
    L.build_call closeimg_func [| (expr builder e) |] "close" builder
      | SCall("save", [e1; e2]) ->
    L.build_call saveimg_func [| (expr builder e1); (expr builder e2) |] "save" builder
      | SCall (f, act) ->
         let (fdef, fdecl) = StringMap.find f function_decls in
    let actuals = List.rev (List.map (expr builder) (List.rev act)) in
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

    let rec stmt builder = function
  SBlock sl -> List.fold_left stmt builder sl
      | SExpr e -> let _ = expr builder e in builder 
      | SVar (e1, e2) -> let (tp, s) = e1 in let _ = expr builder (tp, SId(s)) in
                    let _ = match e2 with
                        (tp, SNoassign) -> L.const_int i32_t 0
                      | _ -> expr builder (tp, SAssign(s, e2))


                     in builder
      | SReturn e -> let _ = match fdecl.styp with
                              A.Int -> L.build_ret (expr builder e) builder 
                            | _ -> to_imp (A.string_of_typ fdecl.styp)
                     in builder
      | SIf (predicate, then_stmt, else_stmt) ->
         let bool_val = expr builder predicate in
   let merge_bb = L.append_block context "merge" the_function in
         let branch_instr = L.build_br merge_bb in
   let then_bb = L.append_block context "then" the_function in
         let then_builder = stmt (L.builder_at_end context then_bb) then_stmt in 
   let () = add_terminal then_builder branch_instr in

   let else_bb = L.append_block context "else" the_function in
         let else_builder = stmt (L.builder_at_end context else_bb) else_stmt in
   let () = add_terminal else_builder branch_instr in

   let _ = L.build_cond_br bool_val then_bb else_bb builder in

   L.builder_at_end context merge_bb

      | SWhile (predicate, body) ->
   let pred_bb = L.append_block context "while" the_function in
   let _ = L.build_br pred_bb builder in
   let body_bb = L.append_block context "while_body" the_function in
         let while_builder = stmt (L.builder_at_end context body_bb) body in
   let () = add_terminal while_builder (L.build_br pred_bb) in
   let pred_builder = L.builder_at_end context pred_bb in
   let bool_val = expr pred_builder predicate in
   let merge_bb = L.append_block context "merge" the_function in
   let _ = L.build_cond_br bool_val body_bb merge_bb pred_builder in
   L.builder_at_end context merge_bb

      | SFor (e1, e2, e3, body) -> stmt builder
      ( SBlock [SExpr e1 ; SWhile (e2, SBlock [body ; SExpr e3]) ] )
      | s -> to_imp (string_of_sstmt s)
    (* Generate the instructions for the function's body, 
       which mutates the_module *)
    in

    let builder = stmt builder (SBlock fdecl.sbody) in

    add_terminal builder (match fdecl.styp with
        A.Void -> L.build_ret_void
        | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))
    
    in
  (* Build each function (there should only be one for Hello World), 
     and return the final module *)
    List.iter build_function functions; the_module
