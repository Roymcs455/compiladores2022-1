#include "linked.h"


// void main()
// {
//     Nodo *Lista = initList("Hola");
//     char* apuntador = "Hello";
//     Lista = crearNodo(apuntador,Lista);
//     printList(Lista);
//     apuntador = "bye";
//     printList(Lista);
//     Lista = crearNodo(apuntador,Lista);
//     printList(Lista);
// }

Nodo *initList(char *dato)
{
    Nodo *ptr = malloc(sizeof(Nodo));
    ptr->dato = (char*)malloc(sizeof(dato)*sizeof(char));
    if(ptr->dato == NULL)
    {
        printf("Error, no se pudo alocar memoria dinámicamente, el resultado puede no ser correcto\n ");
        return NULL;
    }
    strcpy(ptr->dato,dato);
    ptr->next = NULL;
    ptr->posicion = 0;
    return ptr;
}
Nodo *crearNodo(char *dato,Nodo *lista)
{
    Nodo *ptr = malloc(sizeof(Nodo));
    ptr->posicion = lista->posicion+1;
    ptr->dato = (char*)malloc(sizeof(dato)*sizeof(char));
    if(ptr->dato == NULL)
    {
        printf("Error, no se pudo alocar memoria dinámicamente, el resultado puede no ser correcto\n ");
        return NULL;
    }
    strcpy(ptr->dato,dato);
    ptr->next = lista;
    lista = ptr;
    
    return ptr;
}
void printList(Nodo *lista)
{
    Nodo *pointer = lista;
    while(pointer != NULL)
    {
        printf("%s\n",pointer->dato);
        pointer = pointer->next;
    }
    free(pointer);
}
/*Regresa la posición del dato en la lista, si no se encuentra regresa -1*/
int searchList(char *dato,Nodo *lista)
{
    Nodo *pointer=lista;
    while(pointer != NULL)
    {
        if(strcmp(pointer->dato,dato)==0)
        {
            return pointer->posicion;
        }
        pointer = pointer->next;
    }
    return -1;
}