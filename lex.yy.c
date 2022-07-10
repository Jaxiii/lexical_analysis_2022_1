#include <stdio.h>

extern FILE *yyin, *yyout;

int yywrap();

main(argc, argv) int argc;
char **argv;
{
    ++argv;
    --argc;
    if (argc > 0)
        yyin = fopen(argv[0], "rt");
    else
        yyin = stdin;
    if (argc > 1)
        yyout = fopen(argv[1], "wt");
    else
        yyout = stdout;
    yylex();
    fclose(yyin);
    fclose(yyout);
}

int yywrap()
{
    return 1;
}
