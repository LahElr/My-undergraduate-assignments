%{
/*
This file aims at parsing the token string and executing expression
*/
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <ctype.h>
#include <math.h>

#define YYDEBUG 1

#define tell_value(t)                                  \
    {                                                  \
        if (t.value_type == TYPE_INTEGER)              \
        {                                              \
            printf("%d", t.token_value.integer_value); \
        }                                              \
        else                                           \
        {                                              \
            printf("%f", t.token_value.float_value);   \
        }                                              \
    }

char tell_operator(int op)
{
    switch (op)
    {
    case 0:
        return '+';
    case 1:
        return '-';
    case 2:
        return '*';
    case 3:
        return '/';
    case 4:
        return '^';
    }
}

#define tell_operating(a, b, c, op)        \
    {                                      \
        tell_value(a);                     \
        printf(" %c ", tell_operator(op)); \
        tell_value(b);                     \
        printf(" = ");                     \
        tell_value(c);                     \
        printf(".\n");                     \
    }

%}

%code requires {

typedef enum
{
    TYPE_INTEGER,
    TYPE_FLOAT,
    TYPE_OPERATOR,
    TYPE_PUNCTUATION
} value_type_t;

typedef enum
{
    OPERATOR_ADD,
    OPERATOR_MINUS,
    OPERATOR_MULT,
    OPERATOR_DIVIDE,
    OPERATOR_POWER
} operator_value_t;

typedef enum
{
    PUNCTUATION_LPARENTHESIS,
    PUNCTUATION_RPARENTHESIS
} punctuation_value_t;

typedef union
{
    int integer_value;
    float float_value;
    operator_value_t operator_value;
    punctuation_value_t punctuation_value;
} token_value_t;

typedef struct
{
    value_type_t value_type;
    token_value_t token_value;
} type;

#define YYLTYPE type
#define YYSTYPE type

}

%start command

%token LPAR RPAR
%token INTEGER
%token FLOAT

%left ADD MINUS
%left MULT DIVIDE
%right POWER
%right UMINUS

%%

command : exp {
    if ($1.value_type == TYPE_INTEGER)
    {
        printf("%d\n", $1.token_value.integer_value);
    }
    else
    {
        printf("%f\n", $1.token_value.float_value);
    }
}

exp : LPAR exp RPAR {
            $$ = $2;
        }
    | exp MULT exp {
            if ($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_INTEGER;
                $$.token_value.integer_value = ($1.token_value.integer_value) * ($3.token_value.integer_value);
            }
            else if ($1.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ((float)($1.token_value.integer_value)) * ($3.token_value.float_value);
            }
            else if ($3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ($1.token_value.float_value) * ((float)($3.token_value.integer_value));
            }
            else
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ($1.token_value.float_value) * ($3.token_value.float_value);
            }
            // tell_operating($1, $3, $$, OPERATOR_MULT);
        }
    | exp DIVIDE exp {
            if (($2.value_type == TYPE_INTEGER && $2.token_value.integer_value == 0) || ($2.value_type == TYPE_FLOAT && $2.token_value.float_value == 0.0))
            {
                yyerror("divide by 0 error.");
            }
            if ($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_INTEGER;
                $$.token_value.integer_value = ($1.token_value.integer_value) / ($3.token_value.integer_value);
            }
            else if ($1.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ((float)($1.token_value.integer_value)) / ($3.token_value.float_value);
            }
            else if ($3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ($1.token_value.float_value) / ((float)($3.token_value.integer_value));
            }
            else
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ($1.token_value.float_value) / ($3.token_value.float_value);
            }
            // tell_operating($1, $3, $$, OPERATOR_DIVIDE);
        }
    | exp ADD exp {
            if ($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_INTEGER;
                $$.token_value.integer_value = ($1.token_value.integer_value) + ($3.token_value.integer_value);
            }
            else if ($1.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ((float)($1.token_value.integer_value)) + ($3.token_value.float_value);
            }
            else if ($3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ($1.token_value.float_value) + ((float)($3.token_value.integer_value));
            }
            else
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ($1.token_value.float_value) + ($3.token_value.float_value);
            }
            // tell_operating($1, $3, $$, OPERATOR_ADD);
        }
    | exp MINUS exp {
            if ($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_INTEGER;
                $$.token_value.integer_value = ($1.token_value.integer_value) - ($3.token_value.integer_value);
            }
            else if ($1.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ((float)($1.token_value.integer_value)) - ($3.token_value.float_value);
            }
            else if ($3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ($1.token_value.float_value) - ((float)($3.token_value.integer_value));
            }
            else
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = ($1.token_value.float_value) - ($3.token_value.float_value);
            }
            // tell_operating($1, $3, $$, OPERATOR_MINUS);
        }
    | exp POWER exp {
            if ($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = (float)pow((double)($1.token_value.integer_value) , (double)($3.token_value.integer_value));
            }
            else if ($1.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = (float)pow(((double)($1.token_value.integer_value)) , (double)($3.token_value.float_value));
            }
            else if ($3.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = (float)pow((double)($1.token_value.float_value) , ((double)($3.token_value.integer_value)));
            }
            else
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = (float)pow((double)($1.token_value.float_value) , (double)($3.token_value.float_value));
            }
            // tell_operating($1, $3, $$, OPERATOR_POWER);
    }
    | MINUS exp %prec UMINUS {
            if ($2.value_type == TYPE_INTEGER)
            {
                $$.value_type = TYPE_INTEGER;
                $$.token_value.integer_value = -($2.token_value.integer_value);
            }
            else
            {
                $$.value_type = TYPE_FLOAT;
                $$.token_value.float_value = -($2.token_value.float_value);
            }
            // tell_operating($2, $2, $$, OPERATOR_MINUS);
        }
    | ADD exp %prec UMINUS {
            $$ = $2;
        }
    | number {
            $$ = $1;
            // tell_value($$);
            // printf(" <- number.\n");
        }
    ;

number : FLOAT {
                $$ = $1;
            }
       | INTEGER {
                $$ = $1;
            }
       ;

%%

int main()
{
    yydebug = 0;
    printf("use Ctrl-C to exit.\n");
    while(1)
    {
        printf("please input:");
        yyparse();
    }
    return 0;
}

/* print an error message */
int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}