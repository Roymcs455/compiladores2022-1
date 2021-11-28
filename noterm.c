#include <string.h>
#include "noterm.h"
//int curPos;//variable int para localizar el caracter que está siendo analizado.
void Programa(char* str)
{
    curPos = 0;
    if (str[curPos]=="g"||
        str[curPos]=="n"||
        str[curPos]=="d"||
        str[curPos]=="h"||
        str[curPos]=="[")
    //si str[curPos] es igual a c.s. de <Programa>: gndh([
    {
        ListaD(str);
        if (str[curPos]=="[")
        {
            curPos++;
            SerieF(str);
        }
        else
        {
            Error();
        }
        return;
        
    }
}
void ListaD(char* str)
{
    if(str[curPos]=="g"||
        str[curPos]=="n"||
        str[curPos]=="d"||
        str[curPos]=="h")
        {
            curPos++;
            D(str);
            ListaD(str);
        }
    else if(str[curPos]==")"||
        str[curPos]=="[")
        {
            return;
        }
    else
    {
        Error();
    }

}
void SerieF(char* str)
{
    if(str[curPos]=="g"||
        str[curPos]=="n"||
        str[curPos]=="d"||
        str[curPos]=="h"||
        str[curPos]=="v")
    {
        Func(str);
        otraF(str);
        return;
    }
    else
    {
        Error();
    }
}
void otraF(char* str)
{
    if(str[curPos]=="g"||
        str[curPos]=="n"||
        str[curPos]=="d"||
        str[curPos]=="h"||
        str[curPos]=="v")
    {
        curPos++;
        Func(str);
        otraF(str);
        return;
    }
    else if(str[curPos]=="]")
    {
        return;
    }
    else
    {
        Error();
    }
}
void D(char* str)
{
    if (str[curPos]=="g"||
        str[curPos]=="n"||
        str[curPos]=="d"||
        str[curPos]=="h"
    )
    {
        curPos++;
        Tipo(str);
        L(str);
        if(str[curPos]==":")
        {
            return;
        }
        else
        {
            Error();
        }
    }
    else
    {
        Error();
    }
}
void Tipo(char* str)
{
    if (str[curPos]=="g"||
        str[curPos]=="n"||
        str[curPos]=="d"||
        str[curPos]=="h")
    {
        curPos++;
        return;
    }
    
}
void L(char* str)
{
    if (str[curPos]=="a")
    {
        curPos++;
        Valor(str);
        LP(str);
        return;
    }
    else
    {
        Error();
    }
    
}
void LP(char* str)
{
    if(str[curPos]==",")
    {
        curPos++;
        if(str[curPos]=="a")
        {
            curPos++;
            Valor(str);
            LP(str);
        }
        else
        {
            Error();
        }
    }
    else if (str[curPos]==":"||str[curPos]==",")
    {
        return;
    }
    else
    {
        Error();
    }
}
void Valor(char* str)
{
    if(str[curPos]=="=")
    {
        curPos++;
        V(str);
    }
    else if (str[curPos]==":")
    {
        return;
    }
    else
    {
        Error();
    }
}
void V(char* str)
{
    if (str[curPos]=="c"||
        str[curPos]=="s"||
        str[curPos]=="z"||
        str[curPos]=="r")
    {
        curPos++;
        return;
    }
    else
    {
        Error();
    }
    
}
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
void Error()
{
    printf("Error en el átomo %d",curPos);
}