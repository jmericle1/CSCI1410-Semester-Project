section .data
    prompt1 db "Enter the first number: ", 0
    prompt2 db "Enter the second number: ", 0
    prompt3 db "Enter the third number: ", 0
    result_msg db "The sum is: ", 0
    num_buffer db 0        ; Buffer to store input as a single byte (ASCII)

section .bss
    num1 resd 1
    num2 resd 1
    num3 resd 1
    sum resd 1

section .text
    global _start

_start:
    ; Prompt and read first number
    mov eax, 4             ; syscall: write
    mov ebx, 1             ; file descriptor: stdout
    mov ecx, prompt1       ; address of the first prompt
    mov edx, 22            ; length of the first prompt
    int 0x80

    call read_number
    mov [num1], eax        ; store first number in num1

    ; Prompt and read second number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 23
    int 0x80

    call read_number
    mov [num2], eax        ; store second number in num2

    ; Prompt and read third number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt3
    mov edx, 23
    int 0x80

    call read_number
    mov [num3], eax        ; store third number in num3

    ; Calculate sum
    mov eax, [num1]
    add eax, [num2]
    add eax, [num3]
    mov [sum], eax         ; store result in sum

    ; Print result
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 12
    int 0x80

    call print_number
    mov eax, 1             ; syscall: exit
    xor ebx, ebx           ; exit code: 0
    int 0x80

; Subroutine: Read a number from stdin
read_number:
    mov eax, 3             ; syscall: read
    mov ebx, 0             ; file descriptor: stdin
    mov ecx, num_buffer    ; buffer to store the input
    mov edx, 1             ; read 1 byte
    int 0x80

    ; Convert ASCII digit to integer
    movzx eax, byte [num_buffer]
    sub eax, '0'           ; convert ASCII to integer
    ret

; Subroutine: Print a number to stdout
print_number:
    mov eax, [sum]
    add eax, '0'           ; convert integer to ASCII
    mov [num_buffer], al   ; store result in buffer

    mov eax, 4             ; syscall: write
    mov ebx, 1             ; file descriptor: stdout
    mov ecx, num_buffer    ; buffer containing the ASCII digit
    mov edx, 1             ; length of the output
    int 0x80
    ret
