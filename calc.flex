import java_cup.runtime.*;

%%

%class scanner
%unicode
%cup
%line
%column

/* --- ESPAÇOS --- */
WHITESPACE = [ \t\f\r\n\u00A0]+

/* --- COMENTÁRIOS --- */
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment   = "//" [^\r\n]* (\r|\n|\r\n)?
Comment = {TraditionalComment} | {EndOfLineComment}

/* --- LÉXICO --- */
DIGIT = [0-9]+
WORD  = [a-zA-Z_]+

DQUOTE = \"
SQUOTE = \'
STRING_DOUBLE = {DQUOTE}([^\"\\]|\\.)*{DQUOTE}
STRING_SINGLE = {SQUOTE}([^\'\\]|\\.)*{SQUOTE}

/* --- KEYWORDS --- */
KFOR = samurai
KWHILE = ayaya
KIF = butterfly
KELSE = dragonfly
KSWITCH = colors_in_the_sky
KCASE = japan
KDEFAULT = ocean
KTRUE = green
KFALSE = black
KPRINT = bostinha

/* --- OPERADORES --- */
KADD = colorboost
KSUB = wingcut
KMULT = multifly
KDIV = EAST_SEA

%%

<YYINITIAL> {
    
    {WHITESPACE}  { /* ignora */ }
    {Comment}     { /* ignora */ }

    ";"           { return new Symbol(sym.SEMI, yyline+1, yycolumn+1);}
    ":"           { return new Symbol(sym.COLON, yyline+1, yycolumn+1);}
    ","           { return new Symbol(sym.COMMA, yyline+1, yycolumn+1);}
    
    "("           { return new Symbol(sym.LPAREN, yyline+1, yycolumn+1);}
    ")"           { return new Symbol(sym.RPAREN, yyline+1, yycolumn+1);}
    "{"           { return new Symbol(sym.LBRACE, yyline+1, yycolumn+1);}
    "}"           { return new Symbol(sym.RBRACE, yyline+1, yycolumn+1);}
    "["           { return new Symbol(sym.LBRACK, yyline+1, yycolumn+1);}
    "]"           { return new Symbol(sym.RBRACK, yyline+1, yycolumn+1);}

    "="           { return new Symbol(sym.GETS, yyline+1, yycolumn+1); }
    "=="          { return new Symbol(sym.IGUAL, yyline+1, yycolumn+1); }
    "!="          { return new Symbol(sym.NOT, yyline+1, yycolumn+1); }
    "<"           { return new Symbol(sym.MENOR_QUE, yyline+1, yycolumn+1); }
    ">"           { return new Symbol(sym.MAIOR_QUE, yyline+1, yycolumn+1); }
    "<="          { return new Symbol(sym.MENOR_IGUAL, yyline+1, yycolumn+1); }
    ">="          { return new Symbol(sym.MAIOR_IGUAL, yyline+1, yycolumn+1); }

    {KADD}        { return new Symbol(sym.PLUS, yyline+1, yycolumn+1);}
    {KSUB}        { return new Symbol(sym.MINUS, yyline+1, yycolumn+1);}
    {KMULT}       { return new Symbol(sym.TIMES, yyline+1, yycolumn+1);}
    {KDIV}        { return new Symbol(sym.DIV, yyline+1, yycolumn+1);}

    {KFOR}        { return new Symbol(sym.FOR, yyline+1, yycolumn+1);}
    {KWHILE}      { return new Symbol(sym.WHILE, yyline+1, yycolumn+1);}
    {KIF}         { return new Symbol(sym.IF, yyline+1, yycolumn+1); }
    {KELSE}       { return new Symbol(sym.ELSE, yyline+1, yycolumn+1); }
    {KSWITCH}     { return new Symbol(sym.SWITCH, yyline+1, yycolumn+1); }
    {KCASE}       { return new Symbol(sym.CASE, yyline+1, yycolumn+1); }
    {KDEFAULT}    { return new Symbol(sym.DEFAULT, yyline+1, yycolumn+1); }

    {KTRUE}       { return new Symbol(sym.TRUE, yyline+1, yycolumn+1);}
    {KFALSE}      { return new Symbol(sym.FALSE, yyline+1, yycolumn+1);}
    {KPRINT}      { return new Symbol(sym.PRINT, yyline+1, yycolumn+1);}

    {STRING_DOUBLE} {String txt = yytext(); txt = txt.substring(1, txt.length()-1); return new Symbol(sym.STRING, yyline+1, yycolumn+1, txt);}
    {STRING_SINGLE} {String txt = yytext();txt = txt.substring(1, txt.length()-1);return new Symbol(sym.STRING, yyline+1, yycolumn+1, txt);}
    {DIGIT}       { return new Symbol(sym.NUMBER, yyline+1, yycolumn+1, Double.parseDouble(yytext())); }
    {WORD}        { return new Symbol(sym.WORD, yyline+1, yycolumn+1, yytext()); }
    
    
    <<EOF>>       { return new Symbol(sym.EOF, yyline+1, yycolumn+1); }

    .             { System.err.println("Caractere ilegal: " + yytext()); }
}