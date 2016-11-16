/* calendar.c simple program to output a calendar month */

/* Copyright (C) ARM Limited, 2009-2016. All rights reserved. */

/* This code contains a deliberate bug for you to locate using DS-5 Debugger */


#include <stdio.h>

// DS-5 Debugger enables semihosting automatically if either symbols
//  "__auto_semihosting" or "__semihosting_library_function" are present in an image.
// ARM Compiler 6 adds "__semihosting_library_function" automatically to an image
//  at link time if that image uses any semihosting-using functions.
// If compiling with gcc or an earlier release of armcc, use the alias symbol definition:
//void __auto_semihosting(void) __attribute__ ((alias("main")));

extern int mymax1(int x, int y);
extern void day1();

extern long long example1();
extern long long example1c(long long x, long long y);
extern void int2bin_s(unsigned long long);

static void int2bin(unsigned long long x) {
    if (x == 0)
    	printf("0");
    else {
        int2bin(x/2);
        printf("%lld", x % 2);
    }
    return;
}

int euler_in_c() {

	int i = 0;
	int sum = 0;

	while (i < 1000) {
	    if (i % 3 == 0)
	    	sum = sum +i;
	    else if (i % 5 == 0)
	    	sum = sum + i;

	    i++;
	}
    return sum;
}

int foo(int x, int y) {
    return x % y;
}

// ARM does not have a reminader instruction
// sdiv    w2, w0, w1
// msub    w0, w2, w1, w0
// sdiv    quot, x, y
// msub    rem, quot, y, x
//
// minuend - subtrahend = difference
//  To compute x % y
//    quot = x / y
//    rem  = x - quot * y
long long euler_in_asm_c() {

	int i = 0;
	int sum = 0;
    int x = 0;

loop:
    x = i - 1000;

	if (x == 0)
		goto end_loop;

	x = i % 3;

	if (x != 0)
		goto elseifcheck;

	sum = sum + i;
    goto endif;

elseifcheck:
	x = i % 5;

	if (i % 5 != 0)
		goto endif;

	sum = sum + i;

endif:
	i++;
	goto loop;
end_loop:
    return sum;
}

extern long long euler();
extern int popcount(unsigned long long);
extern long long array_sum(long long vec[], int n);

static long long array_sum_c(long long vec[], int n) {

	long long sum = 0;
	for (int i = 0; i < n; i++) {
        sum = sum + vec[i];
    }
	return sum;
}

static long long myvec[] = {4, 9, 22, 3, 11, 15};
static char *hello = "hello";

int main(void) {
	int x = mymax1(10,20);
    int2bin_s(43);
    printf("\n");
    return 0;
}

/*
int main(void) {

    long long vec[] = {4, 9, 22, 3, 11, 15};
    printf("array_sum: %lld\n", array_sum(vec,6));

	int x, y;
	printf("Euler 1: %lld\n", euler_in_c());
	printf("Euler 2: %lld\n", euler_in_asm_c());
	printf("Euler 3: %lld\n", euler());
	printf("popcount: %lld\n", popcount(0xAAAAAAAAAAAAAAAA));

	long long r = example1();
	printf("%lld\n",r);
    //example1c(0,0);
	// read two integers
	printf("Enter two integers: ");
	scanf("%d%d", &x, &y);

    int z = mymax1(x,y);

    printf("The larger is: %d\n", z);
    return 0;
}
*/
