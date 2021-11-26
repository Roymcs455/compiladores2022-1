#include <string.h>
#include "noterm.c"
int curPos;//variable int para localizar el caracter que está siendo analizado.
void AnalizeSyntax(char* str)
{
    curPos = 0;
    if (str[curPos]=="g"||
        str[curPos]=="n"||
        str[curPos]=="d"||
        str[curPos]=="h"||
        str[curPos]=="("||
        str[curPos]=="[")
    //si str[curPos] es igual a c.s. de <Programa>: gndh([
    {
        curPos++;
        


    }
)
}
void ListaD(char* str)
{

}
void SerieF(char* str);
void otraF(char* str);
void D(char* str);
void Tipo(char* str);
void L(char* str);
void LP(char* str);
void Valor(char* str);
void V(char* str);
void A(char* str);
void AP(char* str);
void I(char* str);
void FP(char* str);
void B(char* str);
void W(char* str);
void _for(char* str);
void _ret(char* str);
void Z(char* str);
void E(char* str);
void EP(char* str);
void T(char* str);
void TP(char* str);
void F(char* str);
void R(char* str);
void RP(char* str);
void S(char* str);
void SP(char* str);
void otraS(char* str);
void Func(char* str);
void TipoFunc(char* str);