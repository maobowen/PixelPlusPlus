(*toplevel.ml*)
(* Author: Jiayang (jl4305), Nana (np2630) *)

(* open Ast
let () =
  let usage_msg = "Usage: ./toplevel.native <file.xpp>" in
  let channel = ref stdin in
  Arg.parse [] (fun file -> channel := open_in file) usage_msg;
  let lex_buf = Lexing.from_channel !channel in
  let program = Parser.program Scanner.token lex_buf in
  let result = Ast.string_of_program program in 
  print_string result *)

type action = Ast | Sast | LLVM_IR | Compile_Builtin | Compile

let () =
  let action = ref Compile in
  let set_action a () = action := a in
  let speclist = [
    ("-a", Arg.Unit (set_action Ast), "Print the AST");
    ("-s", Arg.Unit (set_action Sast), "Print the SAST");
    ("-l", Arg.Unit (set_action LLVM_IR), "Print the generated LLVM IR");
    ("-c", Arg.Unit (set_action Compile), "Check and print the generated LLVM IR (default)");
    ("-c2", Arg.Unit (set_action Compile_Builtin), "Check and print the generated LLVM IR for built-in functions");
  ] in  
  let usage_msg = "usage: ./microc.native [-a|-s|-l|-c|-c2] [file.mc]" in
  let channel = ref stdin in
  Arg.parse speclist (fun filename -> channel := open_in filename) usage_msg;
  
  let lexbuf = Lexing.from_channel !channel in
  let compiling_builtin = 
  match !action with
    Compile_Builtin -> true
  | _ -> false in
  let ast = Parser.program Scanner.token lexbuf in  
  match !action with
    Ast -> print_string (Ast.string_of_program ast)
  | _ -> let sast = Semant.check ast compiling_builtin in
    match !action with
      Ast     -> ()
    | Sast    -> print_string (Sast.string_of_sprogram sast)
    | LLVM_IR -> print_string (Llvm.string_of_llmodule (Codegen.translate sast compiling_builtin))
    | Compile | Compile_Builtin -> let m = Codegen.translate sast compiling_builtin in
	Llvm_analysis.assert_valid_module m;
	print_string (Llvm.string_of_llmodule m)

