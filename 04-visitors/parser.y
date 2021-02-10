%skeleton "lalr1.cc"
%require "3.5"

%defines
%define api.token.constructor
%define api.value.type variant
%define parse.assert

%code requires {
    #include <string>
    class Scanner;
    class Driver;
    class Expression;
    class NumberExpression;
    class AddExpression;
    class SubstractExpression;
    class DivExpression;
    class IdentExpression;
    class VariableDecl;
    class VariableDeclBlock;

    class Program;
    class Assignment

}

// %param { Driver &drv }

%define parse.trace
%define parse.error verbose

%code {
    #include "driver.hh"
    #include "location.hh"

    #include "expressions/NumberExpression.h"
    #include "expressions/AddExpression.h"
    #include "expressions/MulExpression.h"
    #include "expressions/DivExpression.h"
    #include "expressions/SubstractExpression.h"
    #include "expressions/IdentExpression.h"
    #include "assignments/Assignment.h"
    #include "Program.h"

    static yy::parser::symbol_type yylex(Scanner &scanner, Driver& driver) {
        return scanner.ScanToken();
    }
}

%lex-param { Scanner &scanner }
%lex-param { Driver &driver }
%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%locations

%define api.token.prefix {TOK_}

%token
    END 0     "end of file"
    BEGIN     "begin"
    VAR       "var"

    FOR       "for"
    DO        "do"
    DOWNTO    "downto"
    WHILE     "while"

    IF        "if"
    ELSE      "else"
    THEN      "then"

    AND       "and"
    NOT       "not"
    OR        "or"

    DIV       "div"
    MOD       "mod"

    WRITE     "write"
    READ      "read"
    WRITELN   "writeln"
    READLN    "readln"

    MINUS     "-"
    PLUS      "+"
    STAR      "*"
    SLASH     "/"
    LPAREN    "("
    RPAREN    ")"
    ASSIGN    ":="

    GEQ       ">="
    GREATER   ">"
    LESS      "<"
    LEQ       "<="
    EQ        "="
    NEQ       "<>"

    SEMICOLON ";"
    COMMA     ","
    COLON     ":"
    DOT       "."
;

%token <std::string> IDENTIFIER "identifier"
%token <int> NUMBER "number"

%nterm <Expression*> Expr
%nterm <Program*> unit
%nterm <If*> If_Statement
%nterm <For*> For_Statement
%nterm <While*> While_Statement
%nterm <Read*> Read_Statement
%nterm <Write*> Write_Statement
%nterm <Assignment*> Assignment
%nterm <std::vector<VariableDeclBlock*>> VariableDeclBlock
%nterm <VariableDeclBlock*> VariableDecl
//%nterm <std::vector<Statement*>> StatementBlock
//%nterm <std::vector<Statement*>> Statement
%nterm <Statement*> Statement
%nterm <StatementBlock*> StatementBlock
%nterm <CodeBlock*> CodeBlock

// %printer { yyo << $$; } <*>;

%%

%start unit;
unit: program {driver.program = $1;}

program:  "program" "identifier" ";" "var" VariableDeclBlock "begin" StatementBlock "end" "." {$$ = new Program($2, $5, $7); driver.program = $$;}
        | "program" "identifier" ";" "begin" StatementBlock "end" "." {$$ = new Program($2, {}, $5);}

VariableDeclBlock:    VariableDecl
                    | VariableDecl VariableDeclBlock

VariableDecl:     "identifier" ":" "identifier" ";"
                | "identifier" "," VariableDecl

StatementBlock:   Statement 
                | Statement StatementBlock

Statement:    Assignment
            | IfStatement
            | ForStatement
            | WhileStatement
            | ReadStatement
            | WriteStatement
            

Assignment: IDENTIFIER ":=" Expr ";"

IfStatement:     "if" Expr "then" CodeBlock ";"
                | "if" Expr "then" CodeBlock "else" CodeBlock ";"
CodeBlock:    Statement
            | "begin" StatementBlock "end"

ForStatement:  "for" "identifier" ":=" Expr "to" Expr "do" StatementSequence         

WhileStatement: "while" Expr "do" StatementSequence
WriteStatement: "write" "(" Expr ")" ";"
ReadStatement: "read" "(" "identifier" ")" ";"


Expr:     Expr "+"   Expr  {$$ = new AddExpression($1, $3);}
        | Expr "-"   Expr  {$$ = new SubExpression($1, $3);}
        | Expr "*"   Expr  {$$ = new MulExpression($1, $3);}
        | Expr "div" Expr  {$$ = new DivlExpression($1, $3);}
        | Expr "mod" Expr  {$$ = new ModExpression($1, $3);}
        | Expr ">"   Expr  {$$ = new GreaterExpression($1, $3);}
        | Expr ">="  Expr  {$$ = new GeqExpression($1, $3);}
        | Expr "<"   Expr  {$$ = new LessExpression($1, $3);}
        | Expr "<="  Expr  {$$ = new LeqExpression($1, $3);}
        | Expr "<>"  Expr  {$$ = new NeqExpression($1, $3);}
        | Expr "="   Expr  {$$ = new EqExpression($1, $3);}
        | Expr "or"  Expr  {$$ = new OrExpression($1, $3);}
        | Expr "and" Expr  {$$ = new AndExpression($1, $3);}
        | "not" Expr       {$$ = new NotExpression($2);}
        | "(" Expr ")"     {$$ = $2;}
        | "int"            {$$ = new IntExpression($1);}
        | "str"            {$$ = new StrExpression($1);}
        | "identifier"     {$$ = new IdentExpression($1);}

%%

void
yy::parser::error(const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}
