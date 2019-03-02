C = cc
LEX = lex
YACC = bison
YACC_FLAGS = -d

RM = /bin/rm

all: datalog

clean: 
	$(RM) datalog.tab.c
	$(RM) datalog.tab.h
	$(RM) lex.yy.c
	$(RM) datalog

datalog.tab.c:
	$(YACC) $(YACC_FLAGS) datalog.y;	

lex.yy.c: datalog.tab.c
	$(LEX) datalog.lex;

datalog: datalog.tab.c lex.yy.c
	$(CC) lex.yy.c datalog.tab.c -o datalog
