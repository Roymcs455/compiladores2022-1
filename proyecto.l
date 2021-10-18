/*Elaborado por: Andrew Sánchez Manjarrez y Rodrigo Macías Eljure*/
/*Fecha de elaboración: 17 de octubre de 2021*/
/*Objetivo del programa: Elaborar un analizador léxico en lex flex que reconozca los componentes*/
/*léxicos pertenecientes a las clases descritas en el documento que detalla los requerimientos.*/
%{
#include <stdio.h>
#include <string.h>
#include "linked.h"

FILE  *tokens;
FILE  *tablaSimbolos;
FILE  *tablaLiterales;  
FILE  *errores;

Nodo *lNum;
Nodo *lString;
Nodo *lIdent;
int linea = 1;
int banderaErrSyn = 0;

char p_reservadas[10][10] = { 
    "cadena",
    "caracter",
    "else",
    "entero",
    "for",
    "if",
    "real",
    "return",
    "void",
    "while"
};
char op_arit[] = "+-*/$";
char op_asig[6][3] = {
    "~",
    "+~",
    "-~",
    "*~",
    "/~",
    "$~"
};
char sim_esp[] = "(){}[]&,:";
char op_rel[6][4] = {
    "^^",
    "^\"",
    "==",
    "^^=",
    "^\"=",
    "<>"
};


%}

/**/
delim \ |\t
/*palabras reservadas*/
class0 "cadena"|"caracter"|"else"|"entero"|"for"|"if"|"real"|"return"|"void"|"while"
/*operadores aritmeticos + - * / $ */
class1 [\+\-\*\/\$]
/*operadores de asignación*/
class2 ({class1}~)|~
/*simbolos especiales*/
class3 [\(\)\{\}\[\]\&\,\:]
/*operadores relacionales*/
caret \^
quot \"
class4 (({caret}({caret}|{quot})|=)=?)|"<>"
/*Identificadores*/
letra [A-Za-z]
digito [0-9]
alfanum {letra}|{digito}
class5 {letra}({alfanum}{0,5})\_
/*constantes numéricas enteras*/
signo [+-]
class6 {signo}?({digito}{1,6})
/*constantes numéricas reales*/
class7 ({digito}+\.)|(\.{digito}+)|({digito}+\.{digito}+)
/*constantes cadenas*/
class8 \"[^"]*\"
class9 '.'
newline \n
%%
{class0}    {
                banderaErrSyn = 0;
                //printf("Se recibió clase 0\n");
                for(int i = 0; i<10; i++)
                {
                    if (strcmp(p_reservadas[i],yytext) == 0 )
                    {
                        fprintf(tokens,"(0,%d)\n",i);
                    }
                }
            }
{class1} {
            banderaErrSyn = 0;
            fprintf(tokens,"(1,%s)\n",yytext);    
        }
{class2}    {
                banderaErrSyn = 0;
                for(int i = 0; i<5; i++)
                {
                    if(strcmp(op_asig[i],yytext)==0)
                    {
                        fprintf(tokens,"(2,%d)\n",i);
                    }
                    if (yytext[0]==36 && yytext[1] == '~')
                    {
                        fprintf(tokens,"(2,5)\n");
                        break;
                    }
                }
            }
{class3}    {
                banderaErrSyn = 0;
                fprintf(tokens,"(3,%s)\n",yytext);
            }
{class4}    {banderaErrSyn = 0;
                for(int i = 0; i<10; i++)
                {
                    if (strcmp(op_rel[i],yytext) == 0 )
                    {
                        fprintf(tokens,"(4,%d)\n",i);
                    }
                }}
{class5}    {   
                banderaErrSyn = 0;
                if(lIdent != NULL)
                {
                    int index =searchList(yytext,lIdent);
                    if(index == -1)
                    {
                        lIdent = crearNodo(yytext,lIdent);
                        fprintf(tokens,"(5,%d)\n",lIdent->posicion);
                    }
                    else
                    {
                        fprintf(tokens,"(5,%d)\n",index);
                    }
                }
                else
                {
                    lIdent = initList(yytext);
                    fprintf(tokens,"(5,0)\n");
                }
            }
{class6}    {
                banderaErrSyn = 0;
                if(lNum != NULL)
                {
                    lNum = crearNodo(yytext,lNum);
                    strcpy(lNum->tipo,"entero");
                    
                    fprintf(tokens,"(6,%d)\n",lNum->posicion);
                }
                else
                {
                    lNum = initList(yytext);
                    strcpy(lNum->tipo,"entero");
                    fprintf(tokens,"(6,%d)\n",lNum->posicion);
                }
            }
{class7}    {
                banderaErrSyn = 0;
                if(lNum != NULL)
                {
                    lNum = crearNodo(yytext,lNum);
                    strcpy(lNum->tipo,"real");
                    
                    fprintf(tokens,"(7,%d)\n",lNum->posicion);
                }
                else
                {
                    lNum = initList(yytext);
                    strcpy(lNum->tipo,"real");
                    fprintf(tokens,"(7,%d)\n",lNum->posicion);
                }
            }
{class8}    {
                banderaErrSyn = 0;
                if(lString != NULL)
                {
                    lString = crearNodo(yytext,lString);
                    strcpy(lString->tipo,"cadena");
                    fprintf(tokens,"(8,%d)\n",lString->posicion);
                }
                else
                {
                    lString = initList(yytext);
                    strcpy(lString->tipo,"cadena");
                    fprintf(tokens,"(8,%d)\n",lString->posicion);
                }
            }
{class9}    {
                banderaErrSyn = 0;   
                fprintf(tokens,"(9,%c)\n",yytext[1]);
            }
{delim}     {}
{newline}  {linea++;}
.           {
                if (errores == NULL)
                {
                    errores = fopen("Errores","w");
                    fprintf(errores,"Lista de errores");
                }
                if(banderaErrSyn == 0)
                {
                    printf("\nError en linea %d:",linea); 
                    fprintf(errores,"\nError en linea %d:\t",linea); 
                }
                printf("%s",yytext);
                fprintf(errores,"%s",yytext);
                banderaErrSyn = 1;
            }
%%
main( int argc, char** argv )
{
    /*Definiendo la entrada del programa*/
    yyin = fopen(argv[1], "r");
    
    /*Creando el archivo con los tokens*/
    tokens = fopen(strcat(argv[1],".tokens"),"w");
    fprintf(tokens,"Tokens:\n");
    
    /*Creando el archivo que almacena la tabla de símbolos*/
    tablaSimbolos = fopen("TablaSimbolos","w");
    fprintf(tablaSimbolos,"Tabla de Símbolos:\n");
    
    /*Creando el archivo que almacenará la tabla de literales*/
    tablaLiterales = fopen("tablaLiterales","w");
    fprintf(tablaLiterales,"Tabla de Literales:\n");
    
    /*Se realiza el análisis léxico del archivo de entrada */
    yylex();

    /*Se llena el archivo contenedor de la tabla de símbolos*/
    if(lIdent != NULL)
        printToFile(lIdent,tablaSimbolos);

    /*Se llena el archivo contenedor la tabla de literales con los literales tipo cadena*/
    if(lString != NULL)
        printToFile(lString,tablaLiterales);
    /*Se llena el archivo contenedor de la tabla de literales con los literales tipo numérico*/
    if(lNum != NULL)
        printToFile(lNum,tablaLiterales);

    /*Se cierran los 3 archivos con las tablas y los tokens, finaliza la ejecución del compilador*/
    close(tokens);
    close(tablaSimbolos);
    close(tablaLiterales);

    close(errores);
}