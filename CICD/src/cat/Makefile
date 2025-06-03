CC=gcc
CFLAGS = -Wall -Werror -Wextra -c

s21_cat:
	$(CC) $(CFLAGS) cat.c cat_flag.c ../common/common.c
	$(CC) -o s21_cat cat.o cat_flag.o common.o

clean:
	rm s21_cat *.o

rebuild:
	rm s21_cat cat.o cat_flag.o common.o
	make