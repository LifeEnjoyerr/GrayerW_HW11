section .data
    inputBuf db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A  ; Hex input
    NumofBytes dd 8
    spaceChar db ' '   ; Space character (no null terminator)

section .bss
    outputBuf resb 25    ; Output buffer

section .text
    global _start

_start:
    lea esi, inputBuf  ; Load address of input array
    lea edi, outputBuf ; Load address of output buffer
    mov ecx, 8         ; Number of data entries

conversionLoop:
    cmp ecx, 0
    je display

    lodsb              ; Load next byte into AL

    ; gets and stores first didget
    mov bl, al
    shr bl, 4
    mov al, bl
    call hex_to_ascii
    mov [edi], al      
    inc edi            ; Move to next position

    ; gets second didget
    mov al, [esi-1]    ; Reload original byte
    and al, 0x0F
    call hex_to_ascii
    mov [edi], al      
    inc edi            ; Move to next position

    ; Append space
    mov al, [spaceChar]  
    mov [edi], al        
    inc edi              

    dec ecx              ; Decrement loop counter
    jmp conversionLoop   ; Repeat for next value

display:
    ; Correctly calculate the output buffer size
    mov edx, edi      ; Copy the end pointer
    sub edx, outputBuf ; Get the actual length of the output

    ; Print output buffer
    mov eax, 4       
    mov ebx, 1       
    mov ecx, outputBuf
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; converts hex to ascii
hex_to_ascii:
    add al, 0x30     ; Convert 0-9 to ASCII
    cmp al, 0x39
    jbe return
    add al, 7        ; Convert A-F to ASCII

return:
    ret