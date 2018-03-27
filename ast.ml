(* Abstract Syntax Tree and functions for printing it *)

type op = Add | Sub | Mult | Div | Equal | Neq 
          | Less | Leq | Greater | Geq |
          And | Or | At | Mtimes | Expo

type uop = Neg | Not | Trans

type typ = Int | Bool | Float | Arr | Void |String 

type bind = typ * string 

type expr =
    Literal of int
  | Fliteral of string
  | BoolLit of bool
  | Id of string
  | Binop of expr * op * expr
  | Unop of uop * expr
  | Assign of string * expr
  | ArrAssign of expr * expr
  | Call of string * expr list
  | Noexpr
  (* add expr *)
  | Noassign
  | Slit of string
  | Arrliteral of expr list
  | Filter of string
  | Filterliteral of expr list
  | Arrsub of expr * expr list
  (*| Mliteral of expr list*)

type stmt =
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt
  | Var of bind * expr

type global = bind * expr

type func_decl = {
    typ : typ;
    fname : string;
    formals : bind list;
    locals : bind list;
    body : stmt list;
  }

type program = global list * func_decl list

(* Pretty-printing functions *)

let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Div -> "/"
  | Equal -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Leq -> "<="
  | Greater -> ">"
  | Geq -> ">="
  | And -> "and"
  | Or -> "or"
  | At -> "@"
  | Mtimes -> ":*"
  | Expo -> "^"

let string_of_uop = function
    Neg -> "-"
  | Not -> "not"
  | Trans -> "**"

let string_of_typ = function
  | Int -> "int"
  | Bool -> "bool"
  | Float -> "float"
  | Void -> "void"
  | Arr -> "arr"
  | String -> "string"


let string_of_bind bind =
string_of_typ (fst bind) ^ " " ^ (snd bind)

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | Fliteral(l) -> l
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id(s) -> s
  | Filter(s) -> s
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""
  (* add expr *)
  | ArrAssign(e1,e2) -> string_of_expr e1 ^ " = " ^ string_of_expr e2  
  | Noassign -> ""
  | Slit(s)-> "\"" ^ s ^ "\""
  | Arrliteral(e) -> "[" ^ String.concat "," (List.map string_of_expr e)^ "]"
  | Filterliteral(e) -> "|" ^ String.concat "->" (List.map string_of_expr e) ^ "|"
  | Arrsub(a, i) -> 
    let rec string_of_list list = match list with
    [] -> ""
    | f::tl -> "[" ^ string_of_expr f ^ "]"^ string_of_list tl
  in string_of_expr a ^  (string_of_list i) 
  (*| Mliteral(e) -> "[" ^ String.concat "," (List.map string_of_expr e)^ "]"*)

let rec string_of_stmt = function
    Block(stmts) ->
      "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n";
  | If(e, s, Block([])) -> "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | If(e, s1, s2) ->  "if (" ^ string_of_expr e ^ ")\n" ^
      string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | For(e1, e2, e3, s) ->
      "for (" ^ string_of_expr e1  ^ " ; " ^ string_of_expr e2 ^ " ; " ^
      string_of_expr e3  ^ ") " ^ string_of_stmt s
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | Var(b, e)-> if string_of_expr e = "" then string_of_bind b ^ ";\n" else string_of_bind b ^" = "^ string_of_expr e ^ ";\n"

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"
let string_of_global (b, e) = if string_of_expr e = "" then string_of_bind b ^ ";\n" else string_of_bind b ^" = "^ string_of_expr e ^ ";\n"

let string_of_formals formals = List.map string_of_bind formals

let string_of_fdecl fdecl =
  "func " ^string_of_typ fdecl.typ ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (string_of_formals fdecl.formals) ^
  ")\n{\n" ^
  (* String.concat "" (List.map string_of_vdecl fdecl.locals) ^ *)
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_program (vars, funcs) =
  String.concat "" (List.map string_of_global vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs)
