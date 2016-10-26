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

int main(void)
{

	// read two integers
	int x, y;
	printf("Enter two integers: ");
	scanf("%d%d", &x, &y);

    int z = mymax1(x,y);

    printf("The larger is: %d\n", z);

    return 0;
}
