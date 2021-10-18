#ifndef LINKED_H
#define LINKED_H
/*Librería hecha por Rodrigo Macías Eljure aka Roymcs455 
V1.0 16 septiembre 2016
V1.1 2 mayo 2018
V1.2 9 febrero 2019
V1.3 17 octubre 2021*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
typedef struct nNodo{
    char* dato;
    int posicion;
    char tipo[8];
    struct nNodo *next;
    struct nNodo *past;
}Nodo;
Nodo *initList(char *dato);
Nodo *crearNodo(char *dato,Nodo *lista);
void printList(Nodo *lista);
int searchList(char *dato,Nodo *lista);
void printToFile(Nodo *lista, FILE* salida);
#endif