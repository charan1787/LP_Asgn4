%{
    #include<stdio.h>
    #include<ctype.h>
    extern FILE *yyin;
%}

%token NUMBER
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'
%right UMINUS
%%
//  lines : lines expression '\n' { printf("\nAnswer:%d\n",$$);}
//         | lines 'n'
//         | /*empty*/
//         | error'\n' {yyerror("Previous line has error, enter again:");
//             yyerrok;}
//         ;
token : expression{printf("\nAnswer=%d\n",$$);
return 0;}
 expression :expression'+'expression {$$=$1+$3;}
            |expression'-'expression {$$=$1-$3;}
            |expression'*'expression {$$=$1*$3;}
            |expression'/'expression {$$=$1/$3;}
            |expression'%'expression {$$=$1%$3;}
            |'('expression')' {$$=$2;}
            | '-' expression %prec UMINUS {$$=-$2;}
            | NUMBER {$$=$1;}
            // | '-' NUMBER {$$=-$2;}
            ;
%%

void main()
{
    // string fileName = "Data.txt";
    // std::ifstream f(fileName, std::ifstream::ate | std::ifstream::binary);
    // int n = f.tellg() / 5 * sizeof(int);
    FILE *f;
    int n;
    f=fopen("input.txt","r");
    yyin=f;
    for(int i=0;i<1;i++)
    {
        yyparse();
    }
}
void yyerror()
{
   printf("\nThe arithmetic expression is not acceptable\n");
}
 //#include "lex.yy.c"
// yylex()
// {
//     int c;
//     while((c=getchar())==' ');
//     if((c=='.')||(isdigit(c)))
//     {
//         ungetc(c,stdin);
//         scanf("%lf",&yylval);
//         return NUMBER;
//     }
//     return c;
// }