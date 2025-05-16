# GrayerW_HW11
313 homework 11
5/15/2025

This program takes 8 hexidecimal values and converts them into ascii values. The values given in the homework assignment are already hardcoded in, however it will work for any set of 8 hexedecimal values should the grader want to swap them. For compileing, a copy and paste of the commands I used to compile the code on the GL server are listed below for the graders convenience.

nasm -f elf32 -g -F dwarf -o GKWhw11.o GKWhw11.asm
ld -m elf_i386 -o GKWhw11 GKWhw11.o
