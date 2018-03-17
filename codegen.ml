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
  and i8_t       = L.i8_type     context 
  and i1_t       = L.i1_type     context
  and float_t    = L.double_type context
  and void_t     = L.void_type   context 
  (* Create an LLVM module -- this is a "container" into which we'll 
     generate actual code *)
  and the_module = L.create_module context "MicroC" in

  (* Convert MicroC types to LLVM types *)
  let ltype_of_typ = function
      A.Int   -> i32_t
    | A.Bool  -> i1_t
    | A.Float -> float_t
    | A.Void  -> void_t

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


  let to_imp str = raise (Failure ("Not yet implemented: " ^ str)) in

  (* Generate the instructions for a trivial "main" function *)
  let build_function fdecl =
    (* Make the LLVM module "aware" of the main function *)
    let main_ty = L.function_type (ltype_of_typ fdecl.styp) [||] in
    let the_function = L.define_function "main" main_ty the_module in
    (* Create an Instruction Builder, which points into a basic block
      and determines where the next instruction should be placed *)
    let builder = L.builder_at_end context (L.entry_block the_function) in
    (* Create a pointer to a format string for printf *)
    let int_format_str = L.build_global_stringptr "%d\n" "fmt" builder
    and float_format_str = L.build_global_stringptr "%g\n" "fmt" builder
    and string_format_str = L.build_global_stringptr "%s\n" "fmt" builder in

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
      | SAssign (s, e) -> let e' = expr builder e in
                          let _  = L.build_store e' (lookup s) builder in e' 
      | SCall ("print", [e]) -> (* Generate a call instruction *)
	  L.build_call printf_func [| int_format_str ; (expr builder e) |]
	    "printf" builder 
      (* Throw an error for any other expressions *)
      | SCall ("printf", [e]) ->
    L.build_call printf_func [| float_format_str ; (expr builder e) |]
      "printf" builder
      | SCall ("printline", [e]) -> 
    L.build_call printf_func [| string_format_str ; (expr builder e) |]
      "printf" builder
      | _ -> to_imp (string_of_sexpr (A.Int,e))  
    in
    (* Deal with a block of expression statements, terminated by a return *)
    let rec stmt builder = function
	SBlock sl -> List.fold_left stmt builder sl
      | SExpr e -> let _ = expr builder e in builder 
      | SReturn e -> let _ = match fdecl.styp with
                              A.Int -> L.build_ret (expr builder e) builder 
                            | _ -> to_imp (A.string_of_typ fdecl.styp)
                     in builder
      | s -> to_imp (string_of_sstmt s)
    (* Generate the instructions for the function's body, 
       which mutates the_module *)
    in ignore(stmt builder (SBlock fdecl.sbody))
  (* Build each function (there should only be one for Hello World), 
     and return the final module *)
  in List.iter build_function functions; the_module
