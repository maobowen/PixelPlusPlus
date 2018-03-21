(* Semantic checking for the MicroC compiler *)

open Ast
open Sast

module StringMap = Map.Make(String)

(* Semantic checking of the AST. Returns an SAST if successful,
   throws an exception if something is wrong.

   Check each global variable, then check each function *)

let check (globals, functions) =

  (* Check if a certain kind of binding has void type or is a duplicate
     of another, previously checked binding *)
  let check_binds (kind : string) (to_check : bind list) = 
    let check_it checked binding = 
      let void_err = "illegal void " ^ kind ^ " " ^ snd binding
      and dup_err = "duplicate " ^ kind ^ " " ^ snd binding
      in match binding with
        (* No void bindings *)
        (Void, _) -> raise (Failure void_err)
      | (_, n1) -> match checked with
                    (* No duplicate bindings *)
                      ((_, n2) :: _) when n1 = n2 -> raise (Failure dup_err)
                    | _ -> binding :: checked
    in  List.fold_left check_it [] (List.sort compare to_check) 
       (* in to_check *)
  in 

  let check_globals (kind : string) (to_check : global list) = 
  
    let check_it (checked, global_map) (binding, ex) = 
      let void_err = "illegal void " ^ kind ^ " " ^ snd binding
      and dup_err = "duplicate " ^ kind ^ " " ^ snd binding

    in

    let check_identifier_assign s = 
        if StringMap.mem s global_map then
          let (t1, t2) = StringMap.find s global_map in
          if t2 = Void then raise (Failure ("uninialized identifier " ^ s))
          else t2
        else raise (Failure ("undeclared identifier " ^ s))
    in

    (* Return a semantically-checked expression, i.e., with a type *)
    let rec expr = function
        Literal l    -> (Int, SLiteral l)
      | Fliteral l   -> (Float, SFliteral l)
      | BoolLit l    -> (Bool, SBoolLit l)
      | Noexpr       -> (Void, SNoexpr)
      | Noassign     -> (Void, SNoassign)
      | Slit s       -> (String, SSlit s)
      | Id s         -> (check_identifier_assign s, SId s)
      | Arrliteral a -> 
          let sa = List.map expr a in (Arr, SArrliteral sa)
      | Arrsub(e1, e2) -> 
          let (t1, e1') = expr e1
          and (t2, e2') = expr e2 in
          let ty = match t1 with
            Arr -> if t2 = Int then t2 else raise (Failure ("illegal type " ^
                       string_of_typ t1 ^ " " ^ string_of_expr e1 ^ 
                       "on subscript, which expects an Arr."))
          | _ -> raise (Failure ("illegal subscript type " ^
                       string_of_typ t2 ^ " " ^ string_of_expr e2 ^ 
                       ", which expects an Int."))
        in (ty, SArrsub((t1, e1'), (t2, e2')))
      | Unop(op, e) as ex -> 
          let (t, e') = expr e in
          let ty = match op with
            Neg when t = Int || t = Float -> t
          | Not when t = Bool -> Bool
          | _ -> raise (Failure ("illegal unary operator " ^ 
                                 string_of_uop op ^ string_of_typ t ^
                                 " in " ^ string_of_expr ex))
          in (ty, SUnop(op, (t, e')))
      | Binop(e1, op, e2) as e -> 
          let (t1, e1') = expr e1 
          and (t2, e2') = expr e2 in
          (* All binary operators require operands of the same type *)
          let same = t1 = t2 in
          (* Determine expression type based on operator and operand types *)
          let ty = match op with
            Add | Sub | Mult | Div when same && t1 = Int   -> Int
          | Add | Sub | Mult | Div when same && t1 = Float -> Float
          | Equal | Neq            when same               -> Bool
          | Less | Leq | Greater | Geq
                     when same && (t1 = Int || t1 = Float) -> Bool
          | And | Or when same && t1 = Bool -> Bool
          | _ -> raise (
        Failure ("illegal binary operator " ^
                       string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
                       string_of_typ t2 ^ " in " ^ string_of_expr e))
          in (ty, SBinop((t1, e1'), op, (t2, e2')))

      in let (tx, ex') = expr ex

      in match (binding, ex) with
        (* No void bindings *)
        ((Void, _), _) -> raise (Failure void_err)
      | ((t1, n1), _) -> if StringMap.mem n1 global_map then raise (Failure dup_err) else
                        let global_map = StringMap.add (snd binding) ((fst binding), tx) global_map in
                        if tx = t1 || tx = Void then (((binding, (tx, ex')) :: checked), global_map)
                      else raise (Failure ("unmatch types " ^ string_of_typ t1 ^  n1 ^ " and " ^ string_of_typ tx))

    in let _ = List.fold_left check_it ([], StringMap.empty) to_check
       in to_check
  in 

  (**** Checking Global Variables ****)

  let globals' = check_globals "global" globals in
  let glob =
      let extract (fst, _) = fst 
      in List.map extract globals' 
  in

  (**** Checking Functions ****)


  (* Collect function declarations for built-in functions: no bodies *)
  let built_in_decls = 
    let add_bind map (name, ty) = StringMap.add name {
      typ = Void; fname = name; 
      formals = [(ty, "x")];
      locals = []; body = [] } map
    in List.fold_left add_bind StringMap.empty [ ("print", Int);
			                         ("printb", Bool);
			                         ("printf", Float);
			                         ("printbig", Int);
			                         ("load", Void);
			                         ("save", Bool);
			                         ("close", Bool) ]
  in

  (* Add function name to symbol table *)
  let add_func map fd = 
    let built_in_err = "function " ^ fd.fname ^ " may not be defined"
    and dup_err = "duplicate function " ^ fd.fname
    and make_err er = raise (Failure er)
    and n = fd.fname (* Name of the function *)
    in match fd with (* No duplicate functions or redefinitions of built-ins *)
         _ when StringMap.mem n built_in_decls -> make_err built_in_err
       | _ when StringMap.mem n map -> make_err dup_err  
       | _ ->  StringMap.add n fd map 
  in

  (* Collect all other function names into one symbol table *)
  let function_decls = List.fold_left add_func built_in_decls functions
  in
  
  (* Return a function from our symbol table *)
  let find_func s = 
    try StringMap.find s function_decls
    with Not_found -> raise (Failure ("unrecognized function " ^ s))
  in

  let _ = find_func "main" in (* Ensure "main" is defined *)

  let check_function func =
    (* Make sure no formals are void or duplicates *)
    let formals' = check_binds "formal" func.formals in

    (* Raise an exception if the given rvalue type cannot be assigned to
       the given lvalue type *)
    let check_assign lvaluet rvaluet err =
       if lvaluet = rvaluet then lvaluet else raise (Failure err)
    in     
	
	(* add local symbol table of variables for this function *)
	let rec find_locals stmt_list locals= match stmt_list with
		| Var (b,e):: tl -> b :: (find_locals tl locals)
		| Block sl :: tl -> 
			let rec find_locals_in_block sl locals= match sl with
            | Block sl :: tl  -> find_locals_in_block (sl @ tl) locals(* Flatten blocks *)
            | Var(b,e) :: tl  -> (b :: (find_locals tl locals)) @ (find_locals_in_block tl locals)
            | _ 			  -> []
          	in (find_locals_in_block sl locals) @ (find_locals tl locals)
		| _ -> []   
	in 
    
	let locals = find_locals func.body [] in
	let locals' = check_binds "local" locals in
    let symbols = List.fold_left (fun m (ty, name) -> StringMap.add name ty m)
	                StringMap.empty (glob @ formals' @locals')
    in
    (* Return a variable from our local symbol table *)
    let type_of_identifier s =
      try StringMap.find s symbols
      with Not_found -> raise (Failure ("undeclared identifier " ^ s))
    in


    (* Return a semantically-checked expression, i.e., with a type *)
    let rec expr = function
        Literal l    -> (Int, SLiteral l)
      | Fliteral l   -> (Float, SFliteral l)
      | BoolLit l    -> (Bool, SBoolLit l)
      | Noexpr       -> (Void, SNoexpr)
      | Noassign     -> (Void, SNoassign)
      | Slit s       -> (String, SSlit s)
      | Id s         -> (type_of_identifier s, SId s)
      | Arrliteral a -> 
          let sa = List.map expr a in (Arr, SArrliteral sa)
      | Arrsub(e1, e2) -> 
          let (t1, e1') = expr e1
          and (t2, e2') = expr e2 in
          let ty = match t1 with
            Arr -> if t2 = Int then t2 else raise (Failure ("illegal type " ^
                       string_of_typ t1 ^ " " ^ string_of_expr e1 ^ 
                       "on subscript, which expects an Arr."))
          | _ -> raise (Failure ("illegal subscript type " ^
                       string_of_typ t2 ^ " " ^ string_of_expr e2 ^ 
                       ", which expects an Int."))
        in (ty, SArrsub((t1, e1'), (t2, e2')))
      | Assign(var, e) as ex -> 
          let lt = type_of_identifier var
          and (rt, e') = expr e in
          let err = "illegal assignment " ^ string_of_typ lt ^ " = " ^ 
            string_of_typ rt ^ " in " ^ string_of_expr ex
          in (check_assign lt rt err, SAssign(var, (rt, e')))
      | Unop(op, e) as ex -> 
          let (t, e') = expr e in
          let ty = match op with
            Neg when t = Int || t = Float -> t
          | Not when t = Bool -> Bool
          | _ -> raise (Failure ("illegal unary operator " ^ 
                                 string_of_uop op ^ string_of_typ t ^
                                 " in " ^ string_of_expr ex))
          in (ty, SUnop(op, (t, e')))
      | Binop(e1, op, e2) as e -> 
          let (t1, e1') = expr e1 
          and (t2, e2') = expr e2 in
          (* All binary operators require operands of the same type *)
          let same = t1 = t2 in
          (* Determine expression type based on operator and operand types *)
          let ty = match op with
            Add | Sub | Mult | Div when same && t1 = Int   -> Int
          | Add | Sub | Mult | Div when same && t1 = Float -> Float
          | Equal | Neq            when same               -> Bool
          | Less | Leq | Greater | Geq
                     when same && (t1 = Int || t1 = Float) -> Bool
          | And | Or when same && t1 = Bool -> Bool
          | _ -> raise (
	      Failure ("illegal binary operator " ^
                       string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
                       string_of_typ t2 ^ " in " ^ string_of_expr e))
          in (ty, SBinop((t1, e1'), op, (t2, e2')))
      | Call(fname, args) as call -> 
          let fd = find_func fname in
          let param_length = List.length fd.formals in
          if List.length args != param_length then
            raise (Failure ("expecting " ^ string_of_int param_length ^ 
                            " arguments in " ^ string_of_expr call))
          else let check_call (ft, _) e = 
            let (et, e') = expr e in 
            let err = "illegal argument found " ^ string_of_typ et ^
              " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr e
            in (check_assign ft et err, e')
          in 
          let args' = List.map2 check_call fd.formals args
          in (fd.typ, SCall(fname, args'))
      (* | Filter s = 
      | Filterliteral el = *)
    in

    let check_bool_expr e = 
      let (t', e') = expr e
      and err = "expected Boolean expression in " ^ string_of_expr e
      in if t' != Bool then raise (Failure err) else (t', e') 
    in

    (* Return a semantically-checked statement i.e. containing sexprs *)
    let rec check_stmt = function
        Expr e -> SExpr (expr e)
      | If(p, b1, b2) -> SIf(check_bool_expr p, check_stmt b1, check_stmt b2)
      | For(e1, e2, e3, st) ->
	  		SFor(expr e1, check_bool_expr e2, expr e3, check_stmt st)
      | While(p, s) -> SWhile(check_bool_expr p, check_stmt s)
      | Return e -> let (t, e') = expr e in
        if t = func.typ then SReturn (t, e') 
        else raise (
	  		Failure ("return gives " ^ string_of_typ t ^ " expected " ^
		   string_of_typ func.typ ^ " in " ^ string_of_expr e))
	    
	    (* A block is correct if each statement is correct and nothing
	       follows any Return statement.  Nested blocks are flattened. *)
      | Block sl -> 
          let rec check_stmt_list = function
              [Return _ as s] -> [check_stmt s]
            | Return _ :: _   -> raise (Failure "nothing may follow a return")
            | Block sl :: ss  -> check_stmt_list (sl @ ss) (* Flatten blocks *)
            | s :: ss         -> check_stmt s :: check_stmt_list ss
            | []              -> []
          in SBlock(check_stmt_list sl)
      | Var (b,e) -> SVar ((type_of_identifier (snd b), snd b), expr e)
    in (* body of check_function *)
    { styp = func.typ;
      sfname = func.fname;
      sformals = formals';
      slocals  = locals';
      sbody = match check_stmt (Block func.body) with
		SBlock(sl) -> sl
      | _ -> let err = "internal error: block didn't become a block?"
      in raise (Failure err)
    }
  in (glob, List.map check_function functions)