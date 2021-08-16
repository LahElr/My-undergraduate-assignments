%{
/*
This file aims at converting all key words of C language out of comment to upper case
*/
#include <stdio.h>
#include <string.h>
#include <ctype.h>

%}

%option noyywrap

space (\n|\r|" "|\s|\t|\0)
operator ("+"|"-"|"*"|"/"|"="|"=="|"|"|"!"|"&"|"&&"|"||"|"("|")"|"["|"]")
punctuation ("("|")"|"{"|"}"|";"|","|".")
block_comment "/*"(([^*]|"*"+[^"*""/"])*)"*"*"*/"
inline_comment "//"(([^\n])*)
string_literal \"(([^\n\"])*)\"
integer ("+"|"-")?[0-9]+
float ("+"|"-")?[0-9]*"."[0-9]*

%%

{block_comment} {
    printf("/*block comment.*/");
}

{inline_comment}/\n {
    printf("/*inline comment.*/");
}

{string_literal} {
    printf("\"a string\"");
}

({space}|{punctuation}|{operator}) {
    printf("%s",yytext);
}

("char"|"double"|"float"|"int"|"long"|"short"|"signed"|"struct"|"unsigned"|"void"|"extern") {
    for (size_t i = 0; i < yyleng; ++i) {
        yytext[i] = toupper(yytext[i]);
    }
    printf("%s", yytext);
}

("for"|"while"|"if"|"switch") {
    for (size_t i = 0; i < yyleng; ++i) {
        yytext[i] = toupper(yytext[i]);
    }
    printf("%s", yytext);
}

("do"|"else") {
    for (size_t i = 0; i < yyleng; ++i) {
        yytext[i] = toupper(yytext[i]);
    }
    printf("%s", yytext);
}

("break"|"continue") {
    for (size_t i = 0; i < yyleng; ++i) {
        yytext[i] = toupper(yytext[i]);
    }
    printf("%s", yytext);
}

"default" {
    for (size_t i = 0; i < yyleng; ++i) {
        yytext[i] = toupper(yytext[i]);
    }
    printf("%s", yytext);
}

("enum"|"union"|"goto"|"case"|"auto"|"extern"|"register"|"static"|"const"|"typedef"|"volatile") {
    for (size_t i = 0; i < yyleng; ++i) {
        yytext[i] = toupper(yytext[i]);
    }
    printf("%s", yytext);
}

"return" {
    for (size_t i = 0; i < yyleng; ++i) {
        yytext[i] = toupper(yytext[i]);
    }
    printf("%s", yytext);
}

"sizeof"/"(" {
    for (size_t i = 0; i < yyleng; ++i) {
        yytext[i] = toupper(yytext[i]);
    }
    printf("%s", yytext);
    
}

"#"([a-z]|[A-Z]|[0-9]|"_")+ {
    //printf("/*pre-process command*/%s",yytext);
    printf("%s",yytext);
}

"#include"{space}+(("<"[^">"]*">")|(\"[^\"]*\")) {
    //printf("/*include library*/%s",yytext);
    printf("%s",yytext);
}

{integer} {
    //printf("/*integer*/%s",yytext);
    printf("%s",yytext);
}

{float} {
    //printf("/*float*/%s",yytext);
    printf("%s",yytext);
}

"$"?([a-z]|[A-Z]|"_")([a-z]|[A-Z]|[0-9]|"_")+ {
    //printf("/*identifier*/%s",yytext);
    printf("%s",yytext);
}

. {
    printf("%s",yytext);
}

%%

int main() {
    yylex();
    return 0;
}
