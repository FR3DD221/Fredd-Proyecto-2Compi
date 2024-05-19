/* JFlex example: partial Java language lexer specification */
package proye1_compi;

import java_cup.runtime.*;

/**
 * This class is a simple example lexer.
 */
%%

%class Lexer
%unicode
%cup
%line
%column

%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
  private Symbol symbol(int type, int yyline, int yycolumn, String value) {
      return new Symbol(type, yyline, yycolumn, value);
  }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*

digit = [0-9]
digitNoZero = [1-9]
dot = "\."
floatNum = ([0-9]*[.])?[0-9]+
true = "true"
Identifier = [A-Za-z]([A-Za-z0-9])*
minPls = ([+-])+


%state STRING
%state CHARSTR

%%

/* keywords */
<YYINITIAL> "abstract"           { return symbol(sym.ABSTRACT, yyline, yycolumn, yytext()); }
<YYINITIAL> "boolean"            { return symbol(sym.BOOLEAN, yyline, yycolumn, yytext()); }
<YYINITIAL> "break"              { return symbol(sym.BREAK, yyline, yycolumn, yytext()); }

<YYINITIAL> {dot}                { return symbol(sym.DOT, yyline, yycolumn, yytext()); }
<YYINITIAL> {DecIntegerLiteral}  { return symbol(sym.INTEGER_LITERAL, yyline, yycolumn, yytext()); }
<YYINITIAL> {floatNum}           { return symbol(sym.FLOATNUM, yyline, yycolumn, yytext()); }
<YYINITIAL> "true"               { return symbol(sym.TRUE, yyline, yycolumn, yytext()); }
<YYINITIAL> "false"              { return symbol(sym.FALSE, yyline, yycolumn, yytext()); }

<YYINITIAL> "-"                  { return symbol(sym.MINUSW, yyline, yycolumn, yytext()); }
<YYINITIAL> "*"                  { return symbol(sym.PRODUCT, yyline, yycolumn, yytext()); }
<YYINITIAL> "/"                  { return symbol(sym.DIVISION, yyline, yycolumn, yytext()); }
<YYINITIAL> "^"                  { return symbol(sym.POWER, yyline, yycolumn, yytext()); }
<YYINITIAL> "--"                 { return symbol(sym.DMINUS, yyline, yycolumn, yytext()); }
<YYINITIAL> "++"                 { return symbol(sym.DPLUS, yyline, yycolumn, yytext()); }
//<YYINITIAL> {minPls}           { return symbol(sym.MINPLS, yyline, yycolumn, yytext()); }
<YYINITIAL> "_"                  { return symbol(sym.DELIMETERBLOCK, yyline, yycolumn, yytext()); }
<YYINITIAL> "%"                  { return symbol(sym.MODULUS, yyline, yycolumn, yytext()); }
<YYINITIAL> ":"                  { return symbol(sym.SEP, yyline, yycolumn, yytext()); }
<YYINITIAL> "int"                { return symbol(sym.INT, yyline, yycolumn, yytext()); }
<YYINITIAL> "char"               { return symbol(sym.CHAR, yyline, yycolumn, yytext()); }
<YYINITIAL> "float"              { return symbol(sym.FLOAT, yyline, yycolumn, yytext()); }
<YYINITIAL> "bool"            { return symbol(sym.BOOL, yyline, yycolumn, yytext()); }
<YYINITIAL> "string"             { return symbol(sym.STRINGT, yyline, yycolumn, yytext()); }
<YYINITIAL> "array"              { return symbol(sym.ARRAY, yyline, yycolumn, yytext()); }
<YYINITIAL> "if"                 { return symbol(sym.IF, yyline, yycolumn, yytext()); }
<YYINITIAL> "else"               { return symbol(sym.ELSE, yyline, yycolumn, yytext()); }


<YYINITIAL> "switch"             { return symbol(sym.SWITCH, yyline, yycolumn, yytext()); }
<YYINITIAL> "case"               { return symbol(sym.CASE, yyline, yycolumn, yytext()); }
<YYINITIAL> "while"              { return symbol(sym.WHILE, yyline, yycolumn, yytext()); }
<YYINITIAL> "for"                { return symbol(sym.FOR, yyline, yycolumn, yytext()); }
<YYINITIAL> "in"                 { return symbol(sym.IN, yyline, yycolumn, yytext()); }
<YYINITIAL> "range"              { return symbol(sym.RANGE, yyline, yycolumn, yytext()); }

<YYINITIAL> ">"                  { return symbol(sym.GRATHER, yyline, yycolumn, yytext()); }
<YYINITIAL> "<"                  { return symbol(sym.LOWER, yyline, yycolumn, yytext()); }
<YYINITIAL> ">="                 { return symbol(sym.GRATHERT, yyline, yycolumn, yytext()); }
<YYINITIAL> "<="                 { return symbol(sym.LOWERT, yyline, yycolumn, yytext()); }
<YYINITIAL> "=="                 { return symbol(sym.COMPARATION, yyline, yycolumn, yytext()); }
<YYINITIAL> "!="                 { return symbol(sym.DIFF, yyline, yycolumn, yytext()); }
<YYINITIAL> "!"                  { return symbol(sym.NEGATION, yyline, yycolumn, yytext()); }
<YYINITIAL> "&&"                 { return symbol(sym.AND, yyline, yycolumn, yytext()); }
<YYINITIAL> "||"                 { return symbol(sym.OR, yyline, yycolumn, yytext()); }


<YYINITIAL> "func"               { return symbol(sym.FUNC, yyline, yycolumn, yytext()); }
<YYINITIAL> "main"               { return symbol(sym.MAIN, yyline, yycolumn, yytext()); }
<YYINITIAL> "param"              { return symbol(sym.PARAM, yyline, yycolumn, yytext()); }
<YYINITIAL> ","                  { return symbol(sym.COMA, yyline, yycolumn, yytext()); }
<YYINITIAL> "("                  { return symbol(sym.PARENTS, yyline, yycolumn, yytext()); }
<YYINITIAL> ")"                  { return symbol(sym.PARENTC, yyline, yycolumn, yytext()); }

<YYINITIAL> "["                  { return symbol(sym.SQUARES, yyline, yycolumn, yytext()); }
<YYINITIAL> "]"                  { return symbol(sym.SQUAREC, yyline, yycolumn, yytext()); }
<YYINITIAL> "loc"                { return symbol(sym.LOC, yyline, yycolumn, yytext()); }
<YYINITIAL> "glob"               { return symbol(sym.GLOB, yyline, yycolumn, yytext()); }
<YYINITIAL> "return"             { return symbol(sym.RETURN, yyline, yycolumn, yytext()); }

<YYINITIAL> "default"            { return symbol(sym.DEFAULT, yyline, yycolumn, yytext()); }
<YYINITIAL> "brake"              { return symbol(sym.BRAKE, yyline, yycolumn, yytext()); }
<YYINITIAL> "print"              { return symbol(sym.PRINT, yyline, yycolumn, yytext()); }
<YYINITIAL> "input"              { return symbol(sym.INPUT, yyline, yycolumn, yytext()); }


<YYINITIAL> ";"                  { return symbol(sym.ENDEXPR, yyline, yycolumn, yytext()); }

<YYINITIAL> {
  /* identifiers */ 
  {Identifier}                   { return symbol(sym.IDENTIFIER, yytext()); }

  /* literals */
  <YYINITIAL> {DecIntegerLiteral}  { return symbol(sym.INTEGER_LITERAL); }
  \"                             { string.setLength(0); yybegin(STRING); }
  \'                             { string.setLength(0); yybegin(CHARSTR); }

  /* operators */
  "="                            { return symbol(sym.EQ); }
  "=="                           { return symbol(sym.EQEQ); }
  "+"                            { return symbol(sym.PLUS); }

  /* comments */
  {Comment}                      { /* ignore */ }

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
}

<STRING> {
  \"                             { yybegin(YYINITIAL); 
                                   return symbol(sym.STRING_LITERAL, 
                                   string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
}

<CHARSTR> {
  \'                             { yybegin(YYINITIAL); 
                                   return symbol(sym.CHARSTR,
                                   string.toString()); }
  [^\n\r\'\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\'                           { string.append('\''); }
  \\                             { string.append('\\'); }
}

/* Manejo de errores */
[^] { throw new RuntimeException("Carácter no válido: " + yytext()); }
