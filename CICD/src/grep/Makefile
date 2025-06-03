CC=gcc
CFLAGS = -Wall -Werror -Wextra -c

s21_grep:
	$(CC) $(CFLAGS) s21_grep.c grep_flag.c ../common/common.c
	$(CC) -o s21_grep s21_grep.o grep_flag.o common.o

clean:
	rm s21_grep *.o

rebuild:
	rm s21_grep s21_grep.o grep_flag.o common.o
	make