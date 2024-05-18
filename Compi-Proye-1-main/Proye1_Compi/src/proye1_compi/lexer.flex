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
<YYINITIAL> "abstract"           { return symbol(sym.ABSTRACT); }
<YYINITIAL> "boolean"            { return symbol(sym.BOOLEAN, yytext()); }
<YYINITIAL> "break"              { return symbol(sym.BREAK); }

<YYINITIAL> {dot}                { System.out.println("punto"); return symbol(sym.DOT, yytext()); }
<YYINITIAL> {DecIntegerLiteral}  { return symbol(sym.INTEGER_LITERAL); }
<YYINITIAL> {floatNum}           { return symbol(sym.FLOATNUM); }
<YYINITIAL> "true"               { return symbol(sym.TRUE); }
<YYINITIAL> "false"              { return symbol(sym.FALSE); }

<YYINITIAL> "-"                  { return symbol(sym.MINUSW); }
<YYINITIAL> "*"                  { return symbol(sym.PRODUCT); }
<YYINITIAL> "/"                  { return symbol(sym.DIVISION); }
<YYINITIAL> "^"                  { return symbol(sym.POWER); }
<YYINITIAL> "--"                 { return symbol(sym.DMINUS); }
<YYINITIAL> "++"                 { return symbol(sym.DPLUS); }
//<YYINITIAL> {minPls}             { return symbol(sym.MINPLS); }
<YYINITIAL> "_"                  { return symbol(sym.DELIMETERBLOCK); }
<YYINITIAL> "%"                  { return symbol(sym.MODULUS); }
<YYINITIAL> ":"                  { return symbol(sym.SEP); }
<YYINITIAL> "int"                { return symbol(sym.INT); }
<YYINITIAL> "char"               { return symbol(sym.CHAR); }
<YYINITIAL> "float"              { return symbol(sym.FLOAT); }
<YYINITIAL> "bool"            { return symbol(sym.BOOL); }
<YYINITIAL> "string"             { return symbol(sym.STRINGT); }
<YYINITIAL> "array"              { return symbol(sym.ARRAY); }
<YYINITIAL> "if"                 { return symbol(sym.IF); }
<YYINITIAL> "else"               { return symbol(sym.ELSE); }


<YYINITIAL> "switch"             { return symbol(sym.SWITCH); }
<YYINITIAL> "case"               { return symbol(sym.CASE); }
<YYINITIAL> "while"              { return symbol(sym.WHILE); }
<YYINITIAL> "for"                { return symbol(sym.FOR); }
<YYINITIAL> "in"                 { return symbol(sym.IN); }
<YYINITIAL> "range"              { return symbol(sym.RANGE); }

<YYINITIAL> ">"                  { return symbol(sym.GRATHER); }
<YYINITIAL> "<"                  { return symbol(sym.LOWER); }
<YYINITIAL> ">="                 { return symbol(sym.GRATHERT); }
<YYINITIAL> "<="                 { return symbol(sym.LOWERT); }
<YYINITIAL> "=="                 { return symbol(sym.COMPARATION); }
<YYINITIAL> "!="                 { return symbol(sym.DIFF); }
<YYINITIAL> "!"                  { return symbol(sym.NEGATION); }
<YYINITIAL> "&&"                 { return symbol(sym.AND); }
<YYINITIAL> "||"                 { return symbol(sym.OR); }


<YYINITIAL> "func"               { return symbol(sym.FUNC); }
<YYINITIAL> "main"               { return symbol(sym.MAIN); }
<YYINITIAL> "param"              { return symbol(sym.PARAM); }
<YYINITIAL> ","                  { return symbol(sym.COMA); }
<YYINITIAL> "("                  { return symbol(sym.PARENTS); }
<YYINITIAL> ")"                  { return symbol(sym.PARENTC); }

<YYINITIAL> "["                  { return symbol(sym.SQUARES); }
<YYINITIAL> "]"                  { return symbol(sym.SQUAREC); }
<YYINITIAL> "loc"                { return symbol(sym.LOC); }
<YYINITIAL> "glob"               { return symbol(sym.GLOB); }
<YYINITIAL> "return"             { return symbol(sym.RETURN); }
<YYINITIAL> "default"            { return symbol(sym.DEFAULT); }
<YYINITIAL> "brake"              { return symbol(sym.BRAKE); }
<YYINITIAL> "print"              { return symbol(sym.PRINT); }
<YYINITIAL> "input"              { return symbol(sym.INPUT); }


<YYINITIAL> ";"                  { return symbol(sym.ENDEXPR); }

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
