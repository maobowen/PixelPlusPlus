(*top.ml*)
(* 
    Tasks Board:

    1.ast.ml, parser.mly, scanner.mll needs change to Pixel++ grammar
    2.only handle one function in one program with (res,map) output needs change to List (res,map) 
    3.only handle int type var needs add more type
    4.if, for, while statement needs implement
*)
open Ast
(* module StringMap = Map.Make(String)
let map = StringMap.empty
let rec eval_expr (res,map) expr= match expr with
  | Literal(x) -> (x,map)
  | Id(x) -> if StringMap.mem x map then (StringMap.find x map,map) else (0,map)
  | Binop(e1, op, e2) -> 
      let result = 
      let (v1,_) = eval_expr (res,map) e1 and (v2,_) = eval_expr (res,map) e2 in match op with
    	| Add -> v1 + v2
      | Sub -> v1 - v2
      | Mult -> v1 * v2
      | Div -> v1 / v2 in (result, map)
  | Assign(s1,e1) ->
      let (v1,m) = eval_expr (res,map) e1 in
      (v1,StringMap.add s1 v1 m)
  
let rec eval_stmt (res,map) stmt = match stmt with
  | Expr(x)-> eval_expr (res,map) x
  | Return(x) -> eval_expr (res,map) x
  | Block(x) -> List.fold_left eval_stmt (res,map) x
(*only handle one function now*)
let eval_func func = match func with
  | x::tl ->x

let eval_program program = match program with
  | (var,func)-> eval_func func
 *)
(* let () =
  let lex_buf = Lexing.from_channel stdin in
  let program = Parser.program Scanner.token lex_buf in
  let fdecl =eval_program program  in
  let stmt = fdecl.body in 
  let (result,_) = List.fold_left eval_stmt (0,map) stmt in
  print_endline (string_of_int result) *)
let () =
  let usage_msg = "usage: ./top.native [file.xpp]" in
  let channel = ref stdin in
  Arg.parse [] (fun file -> channel := open_in file) usage_msg;
  let lex_buf = Lexing.from_channel !channel in
  let program = Parser.program Scanner.token lex_buf in
  let result = Ast.string_of_program program in 
  print_string result
