/* Ocamlyacc parser for Pixel++ */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET QUOTE WRAP COMMA PLUS MINUS TIMES DIVIDE TRANS MTIMES EXPO ASSIGN
%token NOT EQ NEQ LT LEQ GT GEQ AND OR
%token FIL AT
%token RETURN IF ELSE FOR WHILE INT ARR BOOL FLOAT VOID STRING
%token <int> LITERAL
%token <bool> BLIT
%token <string> ID FLIT FILTER
%token EOF
%token FUNC

%start program
%type <Ast.program> program

%nonassoc NOELSE
%nonassoc ELSE
%nonassoc AT
%left COMMA
%right ASSIGN
%left FIL
%left OR AND
%left EQ NEQ LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%right NOT NEG
%left TRANS MTIMES EXPO
%nonassoc LBRACKET RBRACKET


%%

program:
  decls EOF { (List.rev (fst $1), List.rev (snd $1)) }

decls:
   /* nothing */ { ([], [])               }
 | decls global { (($2 :: fst $1), snd $1) }
 | decls fdecl { (fst $1, ($2 :: snd $1)) }

fdecl:
   FUNC typ ID LPAREN formals_opt RPAREN LBRACE stmt_list RBRACE
     { { typ = $2;
	 fname = $3;
	 formals = $5;
	 body = List.rev $8 } }

formals_opt:
    /* nothing */ { [] }
  | formal_list   { List.rev $1 }

formal_list:
    typ ID                   { [($1,$2)]     }
  | formal_list COMMA typ ID { ($3,$4) :: $1 }

typ:
    INT     { Int    }
  | BOOL    { Bool   }
  | FLOAT   { Float  }
  | VOID    { Void   }
  | ARR     { Arr    }
  | STRING  { String }

global:
  |typ ID SEMI { ($1,$2,Noassign)}
  |typ ID ASSIGN expr SEMI {($1,$2,$4)}

stmt_list:
    /* nothing */  { [] }
  | stmt_list stmt { $2 :: $1 }

stmt:
    expr SEMI                               { Expr $1               }
  | RETURN expr_opt SEMI                    { Return $2             }
  | LBRACE stmt_list RBRACE                 { Block(List.rev $2)    }
  | IF LPAREN expr RPAREN stmt %prec NOELSE { If($3, $5, Block([])) }
  | IF LPAREN expr RPAREN stmt ELSE stmt    { If($3, $5, $7)        }
  | FOR LPAREN expr_opt SEMI expr SEMI expr_opt RPAREN stmt
                                            { For($3, $5, $7, $9)   }
  | WHILE LPAREN expr RPAREN stmt           { While($3, $5)         }
  | typ ID SEMI         { Var($1,$2,Noassign)}
  | typ ID ASSIGN expr SEMI { Var ($1,$2,$4)}

expr_opt:
    /* nothing */ { Noexpr }
  | expr          { $1 }

expr:
    LITERAL          { Literal($1)            }
  | FLIT	           { Fliteral($1)           }
  | BLIT             { BoolLit($1)            }
  | ID               { Id($1)                 }
  | FILTER           { Filter($1)      }
  | expr PLUS   expr { Binop($1, Add,   $3)   }
  | expr MINUS  expr { Binop($1, Sub,   $3)   }
  | expr TIMES  expr { Binop($1, Mult,  $3)   }
  | expr DIVIDE expr { Binop($1, Div,   $3)   }
  | expr EQ     expr { Binop($1, Equal, $3)   }
  | expr NEQ    expr { Binop($1, Neq,   $3)   }
  | expr LT     expr { Binop($1, Less,  $3)   }
  | expr LEQ    expr { Binop($1, Leq,   $3)   }
  | expr GT     expr { Binop($1, Greater, $3) }
  | expr GEQ    expr { Binop($1, Geq,   $3)   }
  | expr AND    expr { Binop($1, And,   $3)   }
  | expr OR     expr { Binop($1, Or,    $3)   }
  | expr AT     expr { Binop($1, At,    $3)   }
  | expr MTIMES expr { Binop($1, Mtimes, $3)  }
  | expr EXPO   expr { Binop($1, Expo,  $3)   }
  | MINUS expr %prec NEG { Unop(Neg, $2)      }
  | NOT expr         { Unop(Not, $2)          }
  | TRANS expr       { Unop(Trans, $2)          }
  | ID ASSIGN expr   { Assign($1, $3)         }
  | ID LPAREN args_opt RPAREN { Call($1, $3)  }
  | expr LBRACKET LITERAL RBRACKET { Arrsub($1, $3)  }
  | LPAREN expr RPAREN { $2                   }
  /*add expr*/
  | LBRACKET args_list RBRACKET   {       Arrliteral(List.rev $2)       }
  | WRAP filter_list WRAP         {       Filterliteral(List.rev $2)    }
  | QUOTE ID QUOTE                {       Slit($2)                      }

args_opt:
    /* nothing */ { [] }
  | args_list  { List.rev $1 }

filter_list:
    FILTER                      { [Filter($1)]       }
  | filter_list FIL FILTER { Filter($3) :: $1 }

args_list:
    expr                    { [$1] }
  | args_list COMMA expr { $3 :: $1 }
