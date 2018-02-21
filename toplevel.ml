(*top.ml*)
open Ast
let () =
  let usage_msg = "usage: ./top.native [file.xpp]" in
  let channel = ref stdin in
  Arg.parse [] (fun file -> channel := open_in file) usage_msg;
  let lex_buf = Lexing.from_channel !channel in
  let program = Parser.program Scanner.token lex_buf in
  let result = Ast.string_of_program program in 
  print_string result
