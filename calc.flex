import java_cup.runtime.*;

%%

%class scanner
%unicode
%cup
%line
%column

WHITESPACE = [ \t\n\r]+
DIGIT = [0-9]+
WORD= [a-zA-Z]+

DQUOTE = \"
SQUOTE = \'
STRING_DOUBLE = {DQUOTE}([^\"\\]|\\.)*{DQUOTE}
STRING_SINGLE = {SQUOTE}([^\'\\]|\\.)*{SQUOTE}


// Palavras chaves do usuário

//KRETURN = flyback
KFOR = samurai
KWHILE = ayaya
KIF = butterfly
KELSE = dragonfly
KSWITCH = colors_in_the_sky
KCASE = japan
KDEFAULT = ocean
KTRUE = green
KFALSE = black


KADD = colorboost
KSUB = wingcut
KMULT = multifly
KDIV = EAST_SEA

KPRINT = bostinha

%%

<YYINITIAL> {
    {WHITESPACE}  { /**/ }
    {STRING_DOUBLE} {String txt = yytext(); txt = txt.substring(1, txt.length()-1); return new Symbol(sym.STRING, txt);}
    {STRING_SINGLE} {String txt = yytext();txt = txt.substring(1, txt.length()-1);return new Symbol(sym.STRING, txt);}
    ";"           { return new Symbol(sym.SEMI);}
    ":"           { return new Symbol(sym.COLON);}
    {KADD}        { return new Symbol(sym.PLUS);}
    {KSUB}        { return new Symbol(sym.MINUS);}
    {KMULT}       { return new Symbol(sym.TIMES);}
    {KDIV}        { return new Symbol(sym.DIV);}

    {KFOR}        { return new Symbol(sym.FOR);}
    {KWHILE}      { return new Symbol(sym.WHILE);}

    {KIF}         { return new Symbol(sym.IF); }
    {KELSE}       { return new Symbol(sym.ELSE); }
    {KSWITCH}     { return new Symbol(sym.SWITCH); }
    {KCASE}       { return new Symbol(sym.CASE); }
    {KDEFAULT}    { return new Symbol(sym.DEFAULT); }
    //{KRETURN}     { return new Symbol(sym.RETURN);}

    {KTRUE}       { return new Symbol(sym.TRUE);}
    {KFALSE}      { return new Symbol(sym.FALSE);}
    {KPRINT}      { return new Symbol(sym.PRINT);}

    "("           { return new Symbol(sym.LPAREN);}
    ")"           { return new Symbol(sym.RPAREN);}
    "{"           { return new Symbol(sym.LBRACE);}
    "}"           { return new Symbol(sym.RBRACE);}

    "="           { return new Symbol(sym.GETS); }
    "=="          { return new Symbol(sym.IGUAL); }
    "!="          { return new Symbol(sym.NOT); }
    "<"           { return new Symbol(sym.MENOR_QUE); }
    ">"           { return new Symbol(sym.MAIOR_QUE); }
    "<="          { return new Symbol(sym.MENOR_IGUAL); }
    ">="          { return new Symbol(sym.MAIOR_IGUAL); }


    {DIGIT}       { return new Symbol(sym.NUMBER, Double.parseDouble(yytext())); }
    {WORD}        { return new Symbol(sym.WORD, yytext()); }
    .             { System.err.println("Caractere ilegal: " + yytext()); }
}

