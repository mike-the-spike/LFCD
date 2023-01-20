%{
int yylex();
%}
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define YYDEBUG 1

#define TYPE_INT 1
#define TYPE_STRING 2
#define TYPE_FLOAT 3
 int yylex(void);
 int yyerror(char* s);

%}


%union{
    int l_val;
    char *p_val;
}

%token READ
%token WRITE

%token IF
%token ELSE
%token LOOP
%token FINISH


%token ID
%token <p_val> NUMBER_CONST
%token <p_val> ZERO_CONST
%token STRING_CONST

%token INT
%token STRING
%token CHAR
%token FLOAT
%token BOOL
%token LIST
%token START
%token END
%right '='
%left '<'
%left '>'
%right 'ASSIG'
%left NE
%left GE
%left LE
%left '+' 
%left '-'
%left '*' 
%left '/'

%token '('
%token ')'
%token '{'
%token '}'
%token '['
%token ']'
%token ':'
%token ';'
%token '\''
%token ' '
%token '?'
%token '!'
%token '.'
%token '\n'

%left OR
%left AND

%token ATR
%token EQ

%%
program: START decllist '.' cmpdstmt END 

decllist: declaration | declaration decllist

declaration: ID '(' type ')' '.'

type: type1 | listdecl

type1: BOOL | CHAR | STRING | FLOAT | INT

listdecl: LIST '(' type1 ')'

cmpdstmt: '{' stmt '}'

stmt: simplstmt | structstmt '.'

simplstmt: iostmt | assignstmt | FINISH

iostmt: READ ID | WRITE ID '.'

assignstmt: ID EQ expr '.'

structstmt: cmpdstmt | ifstmt | whilestmt

whilestmt: LOOP ifstmt

ifstmt: IF ':' condition '[' cmpdstmt ']' '.'

condition: expr relation expr

expr: term | term '+' expr | term '-' expr

term: factor | factor '*' term | factor '/' term

factor: '[' expr ']' | ID | NUMBER_CONST

relation: '<' | LE | NE | EQ | GE |'>'

%%

int yyerror(char *s)
{
  printf("%s\n", s);
  return 0;
}

extern FILE *yyin;

int main(int argc, char **argv)
{
  if(argc>1) yyin = fopen(argv[1], "r");
  if((argc>2)&&(!strcmp(argv[2],"-d"))) yydebug = 1;
  if(!yyparse()) fprintf(stderr,"\tO.K.\n");
}