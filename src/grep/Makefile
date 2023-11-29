CC = gcc
CFLAGS = -Wall -Wextra -Werror

all : s21_grep

s21_grep : s21_grep.o
	$(CC) $(CFLAGS) s21_grep.o -o s21_grep

s21_grep.o : s21_grep.c s21_grep.h
	$(CC) $(CFLAGS) -c s21_grep.c -o s21_grep.o

install:
	cp s21_grep test_grep/

clang:
	cp ../../materials/linters/.clang-format .

check:
	clang-format -n *.c *.h

format:
	clang-format -i *.c *.h

clean: 
	rm -rf *.o
		rm -rf s21_grep
	rm -rf ./test_grep/s21_grep
	rm -rf .clang-format
