#include "linked.h"

/*este main sirvió para hacele debug a la librería linked.h*/
// void main()
// {
//     FILE *output = fopen("abduscan","w");
//     Nodo *Lista = initList("Hola");
//     char* apuntador = "Hello";
//     Lista = crearNodo(apuntador,Lista);
//     apuntador = "bye";    
//     Lista = crearNodo(apuntador,Lista);
//     printToFile(Lista,output);
//     close(output);
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
    ptr->past = NULL;
    ptr->posicion = 0;
    return ptr;
}
/*Mete un nodo a la lista, llenandolo con un string*/
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
    lista->past = ptr;
    lista = ptr;
    
    return ptr;
}
/*Imprime la lista en consola desde el último nodo agregado hasta el primero */
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
void printToFile(Nodo *lista, FILE* salida)
{
    Nodo *ptr = lista;
    while(ptr->next != NULL)
    {
        ptr=ptr->next;
    }
    while(ptr != NULL)
    {    
        fprintf(salida,"%d  %s\n",ptr->posicion,ptr->dato);
        ptr =ptr->past;
    }

}