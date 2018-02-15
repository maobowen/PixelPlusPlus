module StringMap = Map.Make (String)

let print_arr arr = Array.iter print_int arr

let trim str = String.sub str 1 (String.length str - 2);;

let arr_of_string str = let trim_str = String.sub str 1 ((String.length str) - 2)
in let str_list = String.split_on_char ',' trim_str
in let int_list = List.map int_of_string str_list
in Array.of_list int_list;;

let matrix_of_string str = Array.of_list (List.map arr_of_string (String.split_on_char ';' (trim str)));;


let plus_fun a b = a + b;;
let minus_fun a b = a - b;;
let mult_fun a b = a * b;;
let div_fun a b = a / b;;

let arr_oper func arr1 arr2 = Array.map2 func arr1 arr2;;
let matrix_oper func m1 m2 = Array.map2 (arr_oper func) m1 m2;;

let string_of_arr arr = let lst = List.map string_of_int (Array.to_list arr) in let temp_str = String.concat "," lst 
in "[" ^ temp_str ^ "]"

let string_of_matrix m = let temp_list1 = Array.to_list m in 
let temp_list2 = List.map string_of_arr temp_list1 in
let str = String.concat ";" temp_list2
in "[" ^ str ^ "]"

let rec combineLists l0 l1 l2 = match l2 with
[] -> []
| [x] -> let [hd] = l1 in [(hd, x)]
| hd::tl -> let hd2::tl2 = l1 in (hd2, hd) :: (combineLists l0 tl2 tl);;

let get_snd (_,b,_) = b;;

(* key: var name, val: var type *)
let rec create_var_map varMap = function
  [] -> varMap
| hd :: tl -> StringMap.add (snd hd) (Ast.string_of_typ (fst hd)) (create_var_map varMap tl);;

let rec create_func_map funcMap = function
  [] -> funcMap
| hd::tl -> StringMap.add (hd: Ast.func_decl).fname hd (create_func_map funcMap tl)


let helper locals key v mymap = if (StringMap.mem key mymap && not (List.mem key (List.map snd locals))) then StringMap.add key v mymap else mymap
let mapIntersect locals mymap mymap3 = StringMap.fold (helper locals) mymap3 mymap


let rec createMap mymap formals (args_opt: Ast.expr list) =
	match args_opt with
	[] -> mymap
|   [x] -> let [hd] = formals in let (v, mymap1, _) = eval mymap StringMap.empty x in StringMap.add (snd hd) v mymap1
|   hd :: tl -> let (v, mymap1, _) = eval mymap StringMap.empty hd in let hd2::tl2 = formals in StringMap.add (snd hd2) v (createMap mymap tl2 tl)
and
 eval mymap funcMap (expr: Ast.expr) = match expr with
    Literal(x) -> (string_of_int x, mymap, funcMap)
  | Slit(x) -> (x, mymap, funcMap)
  | Arrliteral(x) -> (x, mymap, funcMap)
  | Mliteral(x) -> ("["^x^"]", mymap, funcMap)
  | Noexpr -> ("", mymap, funcMap)
  | Id(x) -> (StringMap.find x mymap, mymap, funcMap)
  | BoolLit(x) -> (string_of_bool x, mymap, funcMap)
  | Fliteral(x) -> (x, mymap, funcMap)
  | Assign(x, e) -> let (v, mymap1, funcMap) = eval mymap funcMap e in (v, StringMap.add x v mymap1, funcMap)
  | Binop(e1, op, e2) ->
      (let (v1, mymap1, funcMap1) = eval mymap funcMap e1 in let (v2, mymap2, funcMap2) = eval mymap1 funcMap1 e2 in
      match op with
    	Add -> if String.contains v1 '[' then if (String.sub v1 0 2) = "[[" then (string_of_matrix (matrix_oper plus_fun (matrix_of_string v1) (matrix_of_string v2)), mymap2, funcMap2) else (string_of_arr (arr_oper plus_fun (arr_of_string v1) (arr_of_string v2)), mymap2, funcMap2) else (string_of_int (int_of_string v1 + int_of_string v2), mymap2, funcMap2)
      | Sub -> if String.contains v1 '[' then if (String.sub v1 0 2) = "[[" then (string_of_matrix (matrix_oper minus_fun (matrix_of_string v1) (matrix_of_string v2)), mymap2, funcMap2) else (string_of_arr (arr_oper minus_fun (arr_of_string v1) (arr_of_string v2)), mymap2, funcMap2) else (string_of_int (int_of_string v1 - int_of_string v2), mymap2, funcMap2)
      | Mult -> if String.contains v1 '[' then if (String.sub v1 0 2) = "[[" then (string_of_matrix (matrix_oper mult_fun (matrix_of_string v1) (matrix_of_string v2)), mymap2, funcMap2) else (string_of_arr (arr_oper mult_fun (arr_of_string v1) (arr_of_string v2)), mymap2, funcMap2) else (string_of_int (int_of_string v1 * int_of_string v2), mymap2, funcMap2)
      | Div -> if String.contains v1 '[' then if (String.sub v1 0 2) = "[[" then (string_of_matrix (matrix_oper div_fun (matrix_of_string v1) (matrix_of_string v2)), mymap2, funcMap2) else (string_of_arr (arr_oper div_fun (arr_of_string v1) (arr_of_string v2)), mymap2, funcMap2) else (string_of_int (int_of_string v1 / int_of_string v2), mymap2, funcMap2)
      | Equal -> if v1=v2 then ("true", mymap, funcMap2) else ("false", mymap, funcMap2)
      | Neq -> if v1<>v2 then ("true", mymap, funcMap2) else ("false", mymap, funcMap2)
      | Less -> if (v1 = "true" || v1 = "false") then (string_of_bool (v1 < v2), mymap, funcMap2) else (string_of_bool(int_of_string v1 < int_of_string v2), mymap, funcMap2)
      | Greater -> if (v1 = "true" || v1 = "false") then (string_of_bool (v1 > v2), mymap, funcMap2) else (string_of_bool(int_of_string v1 > int_of_string v2), mymap, funcMap2)
      | Leq -> if (v1 = "true" || v1 = "false") then (string_of_bool (v1 <= v2), mymap, funcMap2) else (string_of_bool(int_of_string v1 <= int_of_string v2), mymap, funcMap2)
      | Geq -> if (v1 = "true" || v1 = "false") then (string_of_bool (v1 >= v2), mymap, funcMap2) else (string_of_bool(int_of_string v1 >= int_of_string v2), mymap, funcMap2)
      | And -> (string_of_bool(bool_of_string v1 && bool_of_string v2), mymap, funcMap2)
      | Or -> (string_of_bool(bool_of_string v1 || bool_of_string v2), mymap, funcMap2))
  | Unop(op, e) ->
  	  (let (v, mymap1, funcMap1) = eval mymap funcMap e in
      match op with
        Neg -> ("-"^v, mymap, funcMap1)
      | Not -> (string_of_bool (not (bool_of_string v)), mymap, funcMap1))
  | Call(fname, args_opt) -> exec_func mymap funcMap (StringMap.find fname funcMap) args_opt
and exec_func mymap funcMap func args_opt =
let mymap2 = createMap mymap (func: Ast.func_decl).formals args_opt in
let(v, mymap3, funcMap3) = exec_stmt_list mymap2 funcMap func.body in
let mymap4 = mapIntersect func.locals mymap mymap3 in
(v, mymap4, funcMap)
and exec_stmt_list mymap funcMap = function
  [] -> ("", mymap, funcMap)
| [hd] -> exec_stmt mymap funcMap hd
| hd::tl -> exec_stmt_list (get_snd (exec_stmt mymap funcMap hd)) funcMap tl
and exec_stmt lvarMap funcMap = function
  Expr e -> eval lvarMap funcMap e
| Return e -> eval lvarMap funcMap e
| Block(stmt_lst) -> (match stmt_lst with
    [e] 		-> exec_stmt lvarMap funcMap e
  | hd :: tl  -> exec_stmt_list (get_snd (exec_stmt lvarMap funcMap hd)) funcMap tl)
| If(e, s, Block([])) -> let (v, lvarMap, funcMap) = eval lvarMap funcMap e in if (v="0" || v="false") then ("", lvarMap, funcMap) else (exec_stmt lvarMap funcMap s)
| If(e, s1, s2) -> let (v, lvarMap, funcMap) = eval lvarMap funcMap e in if (v="0" || v="false") then (exec_stmt lvarMap funcMap s2) else (exec_stmt lvarMap funcMap s1)
| While(e, s) -> exec_while lvarMap funcMap e s
| For(e1, e2, e_opt, s) -> exec_for lvarMap funcMap e1 e2 e_opt s

and exec_for mymap funcMap e1 e2 e_opt s =
let (v1, mymap, funcMap) = eval mymap funcMap e1 in 
let (v2, mymap, funcMap) = eval mymap funcMap e2 in
if (v2="false" or v2="0") then ("", mymap, funcMap)
else let (v3, mymap, funcMap) = exec_stmt mymap funcMap s in let (_, mymap, funcMap) = eval mymap funcMap e_opt in exec_for mymap funcMap Noexpr e2 e_opt s 


and exec_while mymap funcMap e s = let (v, mymap1, funcMap1) 
= eval mymap funcMap e in 
if (v="0" || v="false") then ("", mymap1, funcMap1) 
else (let (v2, mymap2, funcMap2) = exec_stmt mymap1 funcMap1 s in exec_while mymap2 funcMap2 e s)

let is_main func = ((func: Ast.func_decl).fname = "main")

let () =
  let usage_msg = "usage: ./microc.native [file.mc]" in
  let channel = ref stdin in
  Arg.parse [] (fun file -> channel := open_in file) usage_msg;
  let lexbuf = Lexing.from_channel !channel in
  let ast = Parser.program Scanner.token lexbuf in
  let (vars, funcs) = ast in
  let varMap = create_var_map StringMap.empty vars in
  let funcMap = create_func_map StringMap.empty funcs in
  let main_func = List.find is_main funcs in
  let (a,_,_) = (exec_stmt_list StringMap.empty funcMap main_func.body) in
  print_endline(a)



