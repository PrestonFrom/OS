#include "util.h"

void memory_copy(char *source, char *dest, int nbytes) {
    int i = 0;
    for (;i < nbytes; ++i) {
        dest[i] = source[i];
    }
}

void int_to_ascii(int n, char str[]) {
    int minus = (n < 0);
    int count = minus;
    int i = count;

    if (minus) {
        str[count++] = '-';
    }

    do {
        str[count] = (n % 10) + '0';
        ++count;
        n /= 10;
    } while (n != 0);

    for (; i < count / 2; ++i) {
        char temp = str[i];
        int back = count - i - 1 + minus;
        str[i] = str[back];
        str[back] = temp;
    }
    str[count] = '\0';
}
