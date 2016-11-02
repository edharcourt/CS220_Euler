# Copyright (C) ARM Limited, 2009-2016. All rights reserved.
#
# This makefile is intended for use with GNU make
# This example is intended to be built with Linaro bare-metal GCC

TARGET=example1_ARMv8_GCC.axf

CC=aarch64-elf-gcc
LD=aarch64-elf-gcc

# Select build rules based on Windows or Unix
ifdef WINDIR
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(WINDIR)\system32\cmd.exe
else
ifdef windir
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(windir)\system32\cmd.exe
else
DONE=@if [ -f $(1) ]; then echo Build completed.; fi
RM=rm -f $(1)
endif
endif

all: $(TARGET)
	$(call DONE,$(TARGET))
	
rebuild: clean all

clean:
	$(call RM,*.o)
	$(call RM,$(TARGET))

main.o: main.c
	$(CC) -c -march=armv8-a -g -O0 $^ -o $@

mymax.o: mymax.c
	$(CC) -c -march=armv8-a -g -O0 $^ -o $@

example1c.o: example1c.c
	$(CC) -c -march=armv8-a -g -O0 $^ -o $@

mymax1.o : mymax1.S
	$(CC) -c -march=armv8-a -g -o $@ $<

example1.o : example1.s
	$(CC) -c -march=armv8-a -g -o $@ $<

$(TARGET): main.o mymax1.o example1.o example1c.o
	$(LD) --specs=aem-ve.specs -Wl,--build-id=none,-Map=linkmap.txt example1c.o example1.o mymax1.o main.o -o $@