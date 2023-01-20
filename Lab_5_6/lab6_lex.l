%{
#include "lab6_ycc.tab.h"
%}

%option noyywrap
%option caseless
%option yylineno
%option lex-compat

letter      [A-Za-z]
underscore  "_"
digit     [0-9]
non_zero_digit    [1-9]
zero        "0"
identifier  {underscore}*{letter}({letter}|{digit}|{underscore})*
number      ("-")?{non_zero_digit}{digit}*
string      \"[^\n]*\"
delimiter   [;,.]
operator [+*/()<>]|"-"|"["|"]"|"{"|"}"

%x COMMENT

%%
[ \t\n]

"/*" { COMMENT; }

<COMMENT>[^*/]+ { /* ignore anything that is not '*' or '/' */ }
<COMMENT>("*"+)"/" { BEGIN INITIAL; }
<COMMENT>[*/] { /* residual stuff */ }

int				{ return INT; }
float			{ return FLOAT; }
bool 			{ return BOOL; }
str  			{ return STRING; }
list            { return LIST; }
char            { return CHAR; }
if              { return IF; }
loop            { return LOOP; }
finish          { return FINISH; }
else            { return ELSE; }
read           	{ return READ; }
write           { return WRITE; }
START           { return START; }
END             { return END; }

"="         {return ATR;}
"<="        {return LE;}
"=="        {return EQ;}
">="        {return GE;}
"!="        {return NE;}
"||"        {return OR;}
"&&"        {return AND;}

{identifier} {return ID;}
{number}     {return NUMBER_CONST;}
{zero}       {return ZERO_CONST;}
{string}     {return STRING_CONST;}

{delimiter}	{return yytext[0];}
{operator}	{return yytext[0];}

. { printf("Eroare lexicala");}
%%