#!
lex proyecto.l
gcc lex.yy.c linked.c noterm.c -lfl -w -o compilar 
./compilar testfile.txt 
