#!
lex proyecto.l
gcc lex.yy.c linked.c -lfl -w -o compilar 
./compilar testfile.txt testfile.output
