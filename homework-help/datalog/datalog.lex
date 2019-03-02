/* Created By: Justin Meiners (2017) */
  
%{

#include <stdio.h>

#define YYDEBUG 1
#include "datalog.tab.h"

static char comment_buffer[2048];
static size_t comment_index = 0;
static int comment_line_number = 0;

static void token_v(const char* name, const char* data, int line)
{
    printf("(%s, \"%s\", %i)\n", name, data, line);
}

static void token(const char* name)
{
    token_v(name, yytext, yylineno);
}

%}

%option noyywrap
%option yylineno

%x BLOCK_COMMENT
%x COMMENT
%x STRING
%%

,   { token("COMMA"); return COMMA; }
\.  { token("PERIOD"); return PERIOD; }
\?  { token("Q_MARK"); return Q_MARK; }
\(  { token("LEFT_PAREN"); return LEFT_PAREN; }
\)  { token("RIGHT_PAREN"); return RIGHT_PAREN; }
\:- { token("COLON_DASH"); return COLON_DASH; }
\:  { token("COLON"); return COLON; }
\*  { token("MULTIPLY"); return MULTIPLY; }
\+  { token("ADD"); return ADD; }
Schemes/[^a-zA-Z0-9] { token("SCHEMES"); return SCHEMES; }
Facts/[^a-zA-Z0-9] { token("FACTS"); return FACTS; }
Rules/[^a-zA-Z0-9] { token("RULES"); return RULES; }
Queries/[^a-zA-Z0-9] { token("QUERIES"); return QUERIES; }

[a-zA-z][a-zA-z0-9]* { token("ID"); yylval.sval = strdup(yytext); return ID; }

\' { BEGIN(STRING); }
<STRING>[^\']+ { token("STRING"); printf("%s\n", yytext); yylval.sval = strdup(yytext); return STRING_LITERAL; } 
<STRING>\' { BEGIN(INITIAL);  }

\#\| { 
        BEGIN(BLOCK_COMMENT); 
        comment_index = 0; 
        comment_line_number = yylineno;
    }

<BLOCK_COMMENT>.|\n { 
        comment_buffer[comment_index] = yytext[0]; 
        comment_index++; 
    }

<BLOCK_COMMENT>\|\# { 
        comment_buffer[comment_index] = '\0';  
        token_v("COMMENT", comment_buffer, comment_line_number);  
        BEGIN(INITIAL); 
    }

\#/[^\|] { BEGIN(COMMENT); }
<COMMENT>[^\n]+ { token("COMMENT"); }
<COMMENT>\n { BEGIN(INITIAL); } 

[ \n\t\r]+ { }

. { token("UNDEFINED"); }

%%

/*
int main(int argc, const char* argv[])
{
    yylex();
    token("EOF");
    return 0;
}
*/
