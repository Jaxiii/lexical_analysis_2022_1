%{
#include <stdio.h>
extern FILE *yyin;
extern FILE *yyout;
%}

keyword SKIP|IF|ELSE|THEN|FI|WHILE|DO|END|READ|WRITE|LET|IN|INTEGER

sum [+]
subtraction [-]
multiplication [*]
division [/]
power [\^]
assignment [:][=]
lesser [<]
greater [>]
identifier [a-zA-Z][a-zA-Z0-9]*
int [-]?[0-9]+
float [+-]?([0-9]*[.])?[0-9]+
string \"(\\.|[^\\"])*\"
end_of_command [;]
space [[:blank:]\n]+
outro .

%%
{keyword}			{fprintf(yyout,"[Keyword, %s]\n",yytext);}
{assignment} 		{fprintf(yyout,"[Assignment %s]\n",yytext);}
{subtraction} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{sum} 				{fprintf(yyout,"[Operator %s]\n",yytext);}
{multiplication} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{division} 				{fprintf(yyout,"[Operator %s]\n",yytext);}
{power} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{lesser} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{greater} 			{fprintf(yyout,"[Operator %s]\n",yytext);}
{identifier}		{fprintf(yyout,"[Identifier, %s]\n",yytext);}
{int}			{fprintf(yyout,"[Int, %s]\n ",yytext);}
{float}			{fprintf(yyout,"[Float, %s]\n",yytext);}
{string}			{fprintf(yyout,"[String, %s]\n",yytext);}
{end_of_command}	{fprintf(yyout,"[End of Command, %s]\n",yytext);}
{space}				{fprintf(yyout,"[Space]\n");}
{outro}				{fprintf(yyout,"[Outro, %s]\n",yytext);}
%%

int yywrap ();

main(argc, argv)
 int argc;
 char **argv;
    {
	++argv; --argc;
	if(argc > 0)
		yyin = fopen(argv[0],"rt");
	else
		yyin = stdin; 
	if(argc > 1)
		yyout = fopen(argv[1],"wt");
	else
		yyout = stdout;
	yylex();
	fclose(yyin);
	fclose(yyout);
    }

int yywrap() {
	return 1;
}