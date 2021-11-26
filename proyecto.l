/*Elaborado por: Andrew Sánchez Manjarrez y Rodrigo Macías Eljure*/
/*Fecha de elaboración: 17 de octubre de 2021*/
/*Objetivo del programa: Elaborar un analizador léxico en lex flex que reconozca los componentes*/
/*léxicos pertenecientes a las clases descritas en el documento que detalla los requerimientos.*/
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "linked.h"

FILE  *tokens = NULL;
FILE  *tablaSimbolos=NULL;
FILE  *tablaLiterales=NULL;  
FILE  *errores=NULL;

int num_atomos = 3;
char *atomos =NULL;

Nodo *lNum=NULL;
Nodo *lString=NULL;
Nodo *lIdent=NULL;
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
                num_atomos++;
                atomos = realloc(atomos,num_atomos);
                if(atomos == NULL)
                {
                    printf("No se pudo modificar el tamaño de atomos\n");
                    return -1;
                }
                banderaErrSyn = 0;
                //printf("Se recibió clase 0\n");
                for(int i = 0; i<10; i++)
                {
                    if (strcmp(p_reservadas[i],yytext) == 0 )
                    {
                        fprintf(tokens,"(0,%d)\n",i);
                        
                        switch (i)
                        {
                            case 0:
                                strcat(atomos,"h");
                            break;
                            case 1:
                                strcat(atomos,"g");
                            break;
                            case 2:
                                strcat(atomos,"e");
                            break;
                            case 3:
                                strcat(atomos,"n");
                            break;
                            case 4:
                                strcat(atomos,"f");
                            break;
                            case 5:
                                strcat(atomos,"i");
                            break;
                            case 6:
                                strcat(atomos,"d");
                            break;
                            case 7:
                                strcat(atomos,"b");
                            break;
                            case 8:
                                strcat(atomos,"v");
                            break;
                            case 9:
                                strcat(atomos,"w");
                            break;
                            default:
                                
                            break;
                        }

                        break;
                    }
                }
            }
{class1} {
            banderaErrSyn = 0;
            fprintf(tokens,"(1,%s)\n",yytext);    
            num_atomos++;
            atomos = realloc(atomos,num_atomos);
            if(atomos == NULL)
            {
                printf("No se pudo modificar el tamaño de atomos\n");
                return -1;
            }
            strcat(atomos,yytext);
        }
{class2}    {
                banderaErrSyn = 0;
                num_atomos++;
                atomos = realloc(atomos,num_atomos);
                if(atomos == NULL)
                {
                    printf("No se pudo modificar el tamaño de atomos\n");
                    return -1;
                }
                for(int i = 0; i<5; i++)
                {
                    if(strcmp(op_asig[i],yytext)==0)
                    {
                        fprintf(tokens,"(2,%d)\n",i);
                        switch(i)
                        {
                            case 0:
                                strcat(atomos,"=");
                            break;
                            case 1:
                                strcat(atomos,"m");
                            break;
                            case 2:
                                strcat(atomos,"k");
                            break;
                            case 3:
                                strcat(atomos,"p");
                            break;
                            case 4:
                                strcat(atomos,"t");
                            break;
                            default:
                            break;
                        }
                    }
                    if (yytext[0]==36 && yytext[1] == '~')
                    {
                        fprintf(tokens,"(2,5)\n");
                        strcat(atomos,"u");
                        break;
                    }
                }
            }
{class3}    {
                banderaErrSyn = 0;
                fprintf(tokens,"(3,%s)\n",yytext);
                num_atomos++;
                atomos = realloc(atomos,num_atomos);
                if(atomos == NULL)
                {
                    printf("No se pudo modificar el tamaño de atomos\n");
                    return -1;
                }
                strcat(atomos,yytext);
            }
{class4}    {banderaErrSyn = 0;
                num_atomos++;
                atomos = realloc(atomos,num_atomos);
                if(atomos == NULL)
                {
                    printf("No se pudo modificar el tamaño de atomos\n");
                    return -1;
                }
                for(int i = 0; i<10; i++)
                {
                    if (strcmp(op_rel[i],yytext) == 0 )
                    {
                        fprintf(tokens,"(4,%d)\n",i);
                        switch(i)
                        {
                            case 0:
                                strcat(atomos,">");
                            break;
                            case 1:
                                strcat(atomos,"<");
                            break;
                            case 2:
                                strcat(atomos,"?");
                            break;
                            case 3:
                                strcat(atomos,"y");
                            break;
                            case 4:
                                strcat(atomos,"|");
                            break;
                            case 5:
                                strcat(atomos,"¿");
                            break;
                            default:
                            break;
                        }
                        break;
                    }
                }}
{class5}    {   
                num_atomos++;
                atomos = realloc(atomos,num_atomos);
                if(atomos == NULL)
                {
                    printf("No se pudo modificar el tamaño de atomos\n");
                    return -1;
                }
                strcat(atomos,"a");
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
                num_atomos++;
                atomos = realloc(atomos,num_atomos);
                if(atomos == NULL)
                {
                    printf("No se pudo modificar el tamaño de atomos\n");
                    return -1;
                }
                strcat(atomos,"z");
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
                num_atomos++;
                atomos = realloc(atomos,num_atomos);
                if(atomos == NULL)
                {
                    printf("No se pudo modificar el tamaño de atomos\n");
                    return -1;
                }
                strcat(atomos,"r");
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
                num_atomos++;
                atomos = realloc(atomos,num_atomos);
                if(atomos == NULL)
                {
                    printf("No se pudo modificar el tamaño de atomos\n");
                    return -1;
                }
                strcat(atomos,"s");
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
                num_atomos++;
                atomos = realloc(atomos,num_atomos);
                if(atomos == NULL)
                {
                    printf("No se pudo modificar el tamaño de atomos\n");
                    return -1;
                }
                strcat(atomos,"c");
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
    atomos = malloc(num_atomos);
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
    printf("\natomos: %s\nnum_atomos: %d\n",atomos,num_atomos);
}