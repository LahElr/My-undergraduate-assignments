%{
/*
This file aims at parsing the input to the calculator
    and generate tokens for the parser.
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "calculator.y.h"

%}

%option noyywrap

operator ("+"|"-"|"*"|"/"|"^")
integer [0-9]+
float [0-9]*"."[0-9]*
space (" "|\s|\t|\0)
eol (\n)

%%

{integer} {
    yylval.value_type = TYPE_INTEGER;
    yylval.token_value.integer_value = atoi(yytext);
    return INTEGER;
}

{float} {
    yylval.value_type = TYPE_FLOAT;
    yylval.token_value.float_value = atof(yytext);
    return FLOAT;
}

{eol} {
    return 0;
}

"pi" {
    yylval.value_type = TYPE_FLOAT;
    yylval.token_value.float_value = 3.1415926;
    return FLOAT;
}

"(" {
    yylval.value_type = TYPE_PUNCTUATION;
    yylval.token_value.punctuation_value = PUNCTUATION_LPARENTHESIS;
    return LPAR;
}

")" {
    yylval.value_type = TYPE_PUNCTUATION;
    yylval.token_value.punctuation_value = PUNCTUATION_RPARENTHESIS;
    return RPAR;
}

"+" {
    yylval.value_type = TYPE_OPERATOR;
    yylval.token_value.operator_value = OPERATOR_ADD;
    return ADD;
}

"-" {
    yylval.value_type = TYPE_OPERATOR;
    yylval.token_value.operator_value = OPERATOR_MINUS;
    return MINUS;
}

"*" {
    yylval.value_type = TYPE_OPERATOR;
    yylval.token_value.operator_value = OPERATOR_MULT;
    return MULT;
}

"/" {
    yylval.value_type = TYPE_OPERATOR;
    yylval.token_value.operator_value = OPERATOR_DIVIDE;
    return DIVIDE;
}

"^" {
    yylval.value_type = TYPE_OPERATOR;
    yylval.token_value.operator_value = OPERATOR_POWER;
    return POWER;
}

{space}+ {}
. {}

%%