(*top.ml*)
open Ast
module StringMap = Map.Make(String)
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

(* let eval_program program = match program with
  | 
let eval_decls decls = match decls with
  | *)

let () =
  let lex_buf = Lexing.from_channel stdin in
  let stmt = Parser.stmt Scanner.token lex_buf in
  let (result,_) = eval_stmt (0,map) stmt in
  print_endline (string_of_int result)
