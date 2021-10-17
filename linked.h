#ifndef LINKED_H
#define LINKED_H
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
typedef struct nNodo{
    char* dato;
    int posicion;
    char tipo[8];
    struct nNodo *next;
}Nodo;
Nodo *initList(char *dato);
Nodo *crearNodo(char *dato,Nodo *lista);
void printList(Nodo *lista);
int searchList(char *dato,Nodo *lista);
#endif