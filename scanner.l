%{

#define KW_IF 256
#define LIT_INT 257
#define IDENTIFIER 258
#define TOKEN_UNKNOWN 259

int lineNumber = 1;

%}

%%


"if"							{ return KW_IF; }
[0-9]+							{ return LIT_INT; }
[-;=+*,]						{ return yytext[0]; }
([-A-Za-z_]|"]")[-A-Za-z_0-9]*	{ return IDENTIFIER; }
"//".*	
[ \t]
\n								{  ++lineNumber; }
.								{ return TOKEN_UNKNOWN; }


%%

int running = 1;

int main (int argc, char **argv)
{

	int tok;

	if (argc < 2) 
	{
		fprintf(stderr, "Call: a.out file_name\n");
		exit(1);	
	}

	if ((yyin = fopen(argv[1], "r")) == 0)
	{
		fprintf(stderr, "Cannot open file \%s\"\n", argv[1]);
		exit(2);
	}

	while(running)
	{

		tok = yylex();

		if(!running)
			break;

		fprintf(stderr, "[%d, ", lineNumber);
		if (tok < 256)
			fprintf(stderr, "%c] ", tok);
		else
			switch(tok)
			{
				case KW_IF: fprintf(stderr,"KW_IF]"); break;
				case LIT_INT: fprintf(stderr,"LIT_INT]"); break;
				case IDENTIFIER: fprintf(stderr,"identifier]"); break;
				case TOKEN_UNKNOWN: fprintf(stderr,"ERROR: UNKNOWN]"); break;
				default: fprintf(stderr,"ERROR: UNKNOWN LOKO]"); break;
			}
	}	

	exit(0);

}

int yywrap()
{
	running = 0;
	return 1;
}