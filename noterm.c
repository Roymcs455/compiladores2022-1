#include <string.h>
#include "noterm.h"
//int curPos;//variable int para localizar el caracter que está siendo analizado.
void Programa(char* arreglo)
{
    str=arreglo;
    printf("Programa: str[curPos]: %c\n",str[curPos]);
    curPos = 0;
    if (str[curPos]=='g'||
        str[curPos]=='n'||
        str[curPos]=='d'||
        str[curPos]=='h'||
        str[curPos]=='[')
    //si str[curPos] es igual a c.s. de <Programa>: gndh([
    {
        D();
        ListaD();
        if (str[curPos]=='[')
        {
            return;
        }
        else
        {
            Error();
        }
        return;
        
    }
    Error();
}
void ListaD()
{
    printf("ListaD: str[curPos]: %c\n",str[curPos]);
    if(str[curPos]=='g'||
        str[curPos]=='n'||
        str[curPos]=='d'||
        str[curPos]=='h')
        {
            curPos++;
            D();
            ListaD();
        }
    else if(str[curPos]==')'||
        str[curPos]=='[')
        {
            return;
        }
    else
    {
        Error();
    }

}
void SerieF()
{
    printf("SerieF: str[curPos]: %c\n",str[curPos]);
    if(str[curPos]=='g'||
        str[curPos]=='n'||
        str[curPos]=='d'||
        str[curPos]=='h'||
        str[curPos]=='v')
    {
        Func();
        otraF();
        return;
    }
    else
    {
        Error();
    }
}
void otraF()
{
    printf("OtraF: str[curPos]: %c\n",str[curPos]);
    if(str[curPos]=='g'||
        str[curPos]=='n'||
        str[curPos]=='d'||
        str[curPos]=='h'||
        str[curPos]=='v')
    {
        curPos++;
        Func();
        otraF();
        return;
    }
    else if(str[curPos]==']')
    {
        return;
    }
    else
    {
        Error();
    }
}
void D()
{
    printf("D: str[curPos]: %c\n",str[curPos]);
    if (str[curPos]=='g'||
        str[curPos]=='n'||
        str[curPos]=='d'||
        str[curPos]=='h'
    )
    {
        Tipo();
        L();
        if(str[curPos]==':')
        {
            curPos++;
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
void Tipo()
{
    printf("Tipo: str[curPos]: %c\n",str[curPos]);
    if (str[curPos]=='g'||
        str[curPos]=='n'||
        str[curPos]=='d'||
        str[curPos]=='h')
    {
        curPos++;
        return;
    }
    
}
void L()
{
    printf("L: str[curPos]: %c\n",str[curPos]);
    if (str[curPos]=='a')
    {
        curPos++;
        Valor();
        LP();
        return;
    }
    else
    {
        Error();
    }
    
}
void LP()
{
    printf("LP: str[curPos]: %c\n",str[curPos]);
    if(str[curPos]==',')
    {
        curPos++;
        if(str[curPos]=='a')
        {
            curPos++;
            Valor();
            LP();
        }
        else
        {
            Error();
        }
    }
    else if (str[curPos]==':'||str[curPos]==',')
    {
        return;
    }
    else
    {
        Error();
    }
}
void Valor()
{
    printf("Valor: str[curPos]: %c\n",str[curPos]);
    if(str[curPos]=='=')
    {
        curPos++;
        V();
    }
    else if (str[curPos]==':')
    {
        return;
    }
    else
    {
        Error();
    }
}
void V()
{
    printf("V: str[curPos]: %c\n",str[curPos]);
    if (str[curPos]=='c'||
        str[curPos]=='s'||
        str[curPos]=='z'||
        str[curPos]=='r')
    {
        curPos++;
        return;
    }
    else
    {
        Error();
    }
    
}
void A()
{
    if (str[curPos]=='a')
    {
        curPos++;
        A();
        if(str[curPos]==':')
        {
            curPos++;
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
void AP()
{
    if (str[curPos]=='='||
        str[curPos]=='m'||
        str[curPos]=='k'||
        str[curPos]=='p'||
        str[curPos]=='t'||
        str[curPos]=='u')
    {
        curPos++;
        E();
        return;
    }
    else
    {
        Error();
    }
    
}
void I()
{
    if (str[curPos]=='i')
    {
        curPos++;
        if(str[curPos]=='[')
        {
            curPos++;
            R();
            if(str[curPos]==']')
            {
                curPos++;
                FP();
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
    else
    {
        Error();
    }
    
}
void FP()
{
    if (str[curPos]=='(')
    {
        curPos++;
        S();
        if(str[curPos]==')')
        {
            curPos++;
            B();
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
void B()
{
    if (str[curPos]=='e')
    {
        curPos++;
        if (str[curPos]=='(')
        {
            curPos++;
            S();
            if (str[curPos]==')')
            {
                curPos++;
                return;
            }
            
        }
        
    }
    else if (str[curPos]==')')
    {
        return;
    }
    
    else
    {
        Error();
    }
}
void W()
{
    if(str[curPos]=='w')
    {
        curPos++;
        if (str[curPos]=='[')
        {
            curPos++;
            R();
            if (str[curPos]==']')
            {
                curPos++;
                if(str[curPos]=='(')
                {
                    curPos++;
                    S();
                    if (str[curPos]==')')
                    {
                        curPos++;
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
    else
    {
        Error();
    }
}
void _for()
{
    if(str[curPos]=='f')
    {
        curPos++;
        if (str[curPos]=='[')
        {
            curPos++;
            E();
            if (str[curPos]==']')
            {
                curPos++;
                if(str[curPos]=='(')
                {
                    curPos++;
                    S();
                    if (str[curPos]==')')
                    {
                        curPos++;
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
    else
    {
        Error();
    }
}
void _ret()
{
    if (str[curPos]=='b')
    {
        curPos++;
        Z();
        return;
    }
    else
    {
        Error();
    }
    
}
void Z()
{
    if (str[curPos]=='[')
    {
        curPos++;
        E();
        if (str[curPos]==']')
        {
            curPos++;
            if (str[curPos]==':')
            {
                curPos++;
                return;
            }
            
        }
    }
    else if (str[curPos]==':')
    {
        curPos++;
        return;
    }
    
    Error();
    
}
void E()
{
    if (str[curPos]=='('||
        str[curPos]=='a'||
        str[curPos]=='z'||
        str[curPos]=='r'||
        str[curPos]=='[')
    {
        T();
        EP();
        return;
    }
    Error();
}
void EP()
{
    if (str[curPos]=='+'||
        str[curPos]=='-')
    {
        curPos++;
        T();
        EP();
        return;
    }
    else if (str[curPos]==']'||
        str[curPos]==':'||
        str[curPos]=='='||
        str[curPos]=='>'||
        str[curPos]=='<'||
        str[curPos]=='?'||
        str[curPos]=='y'||
        str[curPos]=='|'||
        str[curPos]=='¿')
    {
        return;
    }
    
    Error();
}
void T()
{
    if (str[curPos]=='('||
        str[curPos]=='a'||
        str[curPos]=='z'||
        str[curPos]=='r'||
        str[curPos]=='[')
    {
        F();
        TP();
        return;
    }
    Error();
    
}
void TP()
{
    if (str[curPos]=='*'||
        str[curPos]=='/'||
        str[curPos]==36)
    {
        curPos++;
        F();
        TP();
        return;
    }
    else if (str[curPos]=='+'||
        str[curPos]=='-'||
        str[curPos]==']'||
        str[curPos]==':'||
        str[curPos]==')'||
        str[curPos]=='>'||
        str[curPos]=='<'||
        str[curPos]=='?'||
        str[curPos]=='y'||
        str[curPos]=='|'||
        str[curPos]=='¿'
    )
    {
        return;
    }
    
    Error();
}
void F()
{
    if (str[curPos]=='(')
    {
        curPos++;
        E();
        if (str[curPos]==')')
        {
            curPos++;
            return;
        }
    }
    else if (str[curPos]=='a'||
        str[curPos]=='z'||
        str[curPos]=='r')
    {
        curPos++;
        return;
    }
    else if (str[curPos]=='[')
    {
        curPos++;
        if (str[curPos]=='a')
        {
            curPos++;
            if (str[curPos]==']')
            {
                curPos++;
                return;
            }   
        }
    }
    Error();
}
void R()
{
    if (str[curPos]=='('||
        str[curPos]=='a'||
        str[curPos]=='z'||
        str[curPos]=='r'||
        str[curPos]=='[')
    {
        E();
        RP();
        return;
    }
    Error();
    
}
void RP()
{
    if (str[curPos]=='>'||
        str[curPos]=='<'||
        str[curPos]=='?'||
        str[curPos]=='y'||
        str[curPos]=='|'||
        str[curPos]=='¿')
    {
        curPos++;
        E();
    }
    Error();
}
void S()
{
    if (str[curPos]=='a'||
        str[curPos]=='i'||
        str[curPos]=='w'||
        str[curPos]=='f'||
        str[curPos]=='b'||
        str[curPos]=='[')
    {
        SP();
        otraS();
        return;        
    }
    Error();
}
void SP()
{
    if (str[curPos]=='a')
    {
        A();
    }
    else if (str[curPos]=='i')
    {
        I();
    }
    else if (str[curPos]=='w')
    {
        W();
    }
    else if (str[curPos]=='f')
    {
        _for();
    }
    else if (str[curPos]=='b')
    {
        _ret();
    }
    else if (str[curPos]=='[')
    {
        curPos++;
        if (str[curPos]=='a')
        {
            curPos++;
            if (str[curPos]==']')
            {
                curPos++;
                if (str[curPos]==':')
                {
                    curPos++;
                    return;
                }
            }
        }
    }
    Error();
}
void otraS()
{
    if (str[curPos]=='a'||
        str[curPos]=='i'||
        str[curPos]=='w'||
        str[curPos]=='f'||
        str[curPos]=='b'||
        str[curPos]=='['
        )
    {
        SP();
        otraS();
        return;
    }
    else if (str[curPos]==')')
    {
        return;
    }
    Error();
    
    
}
void Func()
{
    if (str[curPos]=='g'||
        str[curPos]=='n'||
        str[curPos]=='d'||
        str[curPos]=='h'||
        str[curPos]=='v')
    {
        TipoFunc();
        if (str[curPos]=='a')
        {
            curPos++;
            if (str[curPos]=='(')
            {
                curPos++;
                ListaD();
                S();
                if (str[curPos]==')')
                {
                    curPos++;
                    return;
                }
            }
        }
    }
    Error();
}
void TipoFunc()
{
    if (str[curPos]=='g'||
        str[curPos]=='n'||
        str[curPos]=='d'||
        str[curPos]=='h')
    {
        Tipo();
        return;
    }
    else if (str[curPos]=='v')
    {
        curPos++;
        return;
    }
    Error();
    
}
void Error()
{
    printf("Error en el átomo %d\n",curPos);
}