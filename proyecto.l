%{
#include <stdio.h>
#include <string.h>
#include "linked.h"
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
Nodo *ListaNumericos;
Nodo *ListaCadenas;
Nodo *ListaIdentificadores;


%}

/**/
delim \n|\ |\t
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

%%
{class0}    {//printf("Se recibió clase 0\n");
                for(int i = 0; i<10; i++)
                {
                    if (strcmp(p_reservadas[i],yytext) == 0 )
                    {
                        printf("(0,%d)",i);
                    }
                }
            }
{class1} {//printf("Se recibió clase 1\n");
            printf("(1,%s)",yytext);    
        }
{class2}    {for(int i = 0; i<5; i++)
                {
                    if(strcmp(op_asig[i],yytext)==0)
                    {
                        printf("(2,%d)",i);
                    }
                    if (yytext[0]==36 && yytext[1] == '~')
                    {
                        printf("(2,5)");
                        break;
                    }
                }
            }
{class3}    {printf("(3,%s)",yytext);}
{class4}    {for(int i = 0; i<10; i++)
                {
                    if (strcmp(op_rel[i],yytext) == 0 )
                    {
                        printf("(4,%d)",i);
                    }
                }}
{class5}    {   
                if(ListaIdentificadores != NULL)
                {
                    int index =searchList(yytext,ListaIdentificadores);
                    if(index == -1)
                    {
                        ListaIdentificadores = crearNodo(yytext,ListaIdentificadores);
                        printf("(5,%d)",ListaIdentificadores->posicion);
                    }
                    else
                    {
                        printf("(5,%d)",index);
                    }
                }
                else
                {
                    ListaIdentificadores = initList(yytext);
                    printf("(5,0)");
                }
            }
{class6}    {
                if(ListaNumericos != NULL)
                {
                    ListaNumericos = crearNodo(yytext,ListaNumericos);
                    strcpy(ListaNumericos->tipo,"entero");
                    printf("%s",ListaNumericos->tipo);
                    printf("(6,%d)",ListaNumericos->posicion);
                }
                else
                {
                    ListaNumericos = initList(yytext);
                    strcpy(ListaNumericos->tipo,"entero");
                    printf("(6,%d)",ListaNumericos->posicion);
                }
            }
{class7}    {
                if(ListaNumericos != NULL)
                {
                    ListaNumericos = crearNodo(yytext,ListaNumericos);
                    strcpy(ListaNumericos->tipo,"real");
                    printf("%s",ListaNumericos->tipo);
                    printf("(7,%d)",ListaNumericos->posicion);
                }
                else
                {
                    ListaNumericos = initList(yytext);
                    strcpy(ListaNumericos->tipo,"real");
                    printf("%s",ListaNumericos->tipo);
                    printf("(7,%d)",ListaNumericos->posicion);
                }
            }
{class8}    {
                if(ListaCadenas != NULL)
                {
                    ListaCadenas = crearNodo(yytext,ListaCadenas);
                    strcpy(ListaCadenas->tipo,"cadena");
                    printf("%s",ListaCadenas->tipo);
                    printf("(8,%d)",ListaCadenas->posicion);
                }
                else
                {
                    ListaCadenas = initList(yytext);
                    strcpy(ListaCadenas->tipo,"cadena");
                    printf("%s",ListaCadenas->tipo);
                    printf("(8,%d)",ListaCadenas->posicion);
                }
            }
{class9}    {
                printf("(9,%c)",yytext[1]);
            }
{delim}     {}
.           {printf("error léxico\n");}
%%
int main( )
{
    yylex();
    return 0;
}