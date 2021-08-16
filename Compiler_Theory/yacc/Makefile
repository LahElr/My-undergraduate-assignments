all: cal

cal:
	bison --defines='calculator.y.h' -o 'calculator.y.c' 'calculator.y'
	lex -t 'calculator.l' >'calculator.l.c'
	gcc 'calculator.y.c' 'calculator.l.c' -o 'calculator' -lm

clean:
	rm -f calculator.y.h calculator.y.c calculator.l.c calculator
