%{
#include <stdio.h>
extern FILE *yyin;
extern FILE *yyout;
%}
keyword SKIP|IF|ELSE|THEN|FI|WHILE|DO|END|READ|WRITE|LET|IN|INTEGER
plus [+]
minus [-]
multi [*]
div [/]
power [\^]
assignment [:][=]
lesser [<]
greater [>]
identifier [a-zA-Z][a-zA-Z0-9]*
number [-]?[0-9]+
end_of_command [;]
space [[:blank:]\n]+
outro .
%%
{keyword}			{fprintf(yyout,"[Keyword, %s]\n",yytext);}
{assignment} 		{fprintf(yyout,"[Assignment %s]\n",yytext);}
{minus} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{plus} 				{fprintf(yyout,"[Operator %s]\n",yytext);}
{multi} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{div} 				{fprintf(yyout,"[Operator %s]\n",yytext);}
{power} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{lesser} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{greater} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{identifier}		{fprintf(yyout,"[Identifier, %s]\n",yytext);}
{number}			{fprintf(yyout,"[Number, %s]\n",yytext);}
{end_of_command}	{fprintf(yyout,"[End of Command, %s]\n",yytext);}
{space}				{fprintf(yyout,"[Space]\n");}
{outro}				{fprintf(yyout,"[Outro, %s]\n",yytext);}
%%
/* recomendavel declarar sempre funcao yywrap() */
int yywrap ();

/* programa principal */
main(argc, argv)
 int argc;
 char **argv;
    {
	++argv; --argc; 	    /* abre arquivo de entrada se houver */
	if(argc > 0)
		yyin = fopen(argv[0],"rt");
	else
		yyin = stdin;    /* cria arquivo de saida se especificado */
	if(argc > 1)
		yyout = fopen(argv[1],"wt");
	else
		yyout = stdout;
	yylex(); /* scanner gerado por Flex */
	fclose(yyin);
	fclose(yyout);
    }

int yywrap() {
	return 1;
}