CC = gcc
CFLAGS = -Wall -Wextra -Werror

all : s21_cat

s21_cat : s21_cat.o
	$(CC) $(CFLAGS) s21_cat.o -o s21_cat

s21_cat.o : s21_cat.c s21_cat.h
	$(CC) $(CFLAGS) -c s21_cat.c -o s21_cat.o

install:
	cp s21_cat test_cat/

clang:
	cp ../../materials/linters/.clang-format .

check:
	clang-format -n *.c *.h

format:
	clang-format -n *.c *.h

clean: 
	rm -rf *.o
	rm -rf .clang-format
