/* Created By: Justin Meiners (2017) */
 
%{
#include <stdio.h>

#define YYDEBUG 1
void yyerror(const char* str);

%}

%union {
    int ival;
    float fval;
    char *sval;
}

%token COMMA
%token PERIOD
%token Q_MARK
%token LEFT_PAREN
%token RIGHT_PAREN
%token COLON_DASH
%token COLON
%token ADD 
%token MULTIPLY 
%token SCHEMES
%token FACTS
%token RULES
%token QUERIES
%token <sval> ID
%token <sval> STRING_LITERAL

/* Grammer - https://wiki.cs.byu.edu/cs-236/datalog-parser */
%%

program:
       SCHEMES COLON scheme schemeList
       FACTS COLON factList
       RULES COLON ruleList
       QUERIES COLON query queryList;

scheme: ID LEFT_PAREN ID idList RIGHT_PAREN;

schemeList: scheme schemeList | lambda;

idList: COMMA ID idList | lambda;

fact: ID LEFT_PAREN STRING_LITERAL stringList RIGHT_PAREN PERIOD;

factList: fact factList | lambda;

rule: headPredicate COLON_DASH predicate predicateList PERIOD;

ruleList: rule ruleList | lambda;

headPredicate: ID LEFT_PAREN ID idList RIGHT_PAREN

predicate: ID LEFT_PAREN parameter parameterList RIGHT_PAREN

predicateList: COMMA predicate predicateList | lambda;

parameter: STRING_LITERAL | ID | expression

parameterList: COMMA parameter parameterList | lambda;

expression: LEFT_PAREN parameter operator parameter RIGHT_PAREN;

operator: ADD | MULTIPLY;

query: predicate Q_MARK;

queryList: query queryList | lambda;

stringList: COMMA STRING_LITERAL stringList | lambda;

lambda: ;

%%

void yyerror(const char* str)
{
    printf("%s\n", str);
}

int yywrap()
{
    return 1;
}

int main(int argc, const char* argv[])
{
    yyparse();
}

