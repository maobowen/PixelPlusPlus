(* Ocamllex scanner for Pixel++ *)

{ open Parser }

let digit = ['0' - '9']
let digits = digit+
let ary = ['['] digits ([','] digits)* [']']
(*let str = *)

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| "/*"     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| '['	   { LBRACKET }
| ']'	   { RBRACKET }
| '|'	   { WRAP }
| '"'	   { QUOTE}
| ';'      { SEMI }
| ','      { COMMA }
| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVIDE }
| '='      { ASSIGN }
| '@'	   { AT }
| '<'      { LT }
| '>'      { GT }
| '^'      { EXPO }
| ":*"     { MTIMES }
| "**"     { TRANS }
| "=="     { EQ }
| "!="     { NEQ }
| "<="     { LEQ }
| ">="     { GEQ }
| "and"    { AND }
| "or"     { OR }
| "not"    { NOT }
| "->"	   { FIL }
| "if"     { IF }
| "else"   { ELSE }
| "for"    { FOR }
| "while"  { WHILE }
| "return" { RETURN }
| "int"    { INT }
| "string" { STRING }
| "arr"    { ARR }
| "kernel" { KERNEL }
| "bool"   { BOOL }
| "float"  { FLOAT }
| "void"   { VOID }
| "true"   { BLIT(true)  }
| "false"  { BLIT(false) }
| "func"   { FUNC }
| digits as lxm { LITERAL(int_of_string lxm) }
| digits '.'  digit* ( ['e' 'E'] ['+' '-']? digits )? as lxm { FLIT(lxm) }
| "blur" as lxm { FILTER(lxm) }
| "hdr" as lxm { FILTER(lxm) }
| "scifi" as lxm { FILTER(lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']*     as lxm { ID(lxm) }
| ['"']([^'"' '\\' '\n'] | '\\'[^'\n'])*['"'] as lxm { ID2(String.sub lxm 1 (String.length lxm - 2)) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }
