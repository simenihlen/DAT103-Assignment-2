%include "macros.asm"
	
section .data
   STDIN equ 0
   STDOUT equ 1
   SYS_READ equ 3
   SYS_WRITE equ 4
   LINE_SHIFT equ 10
   buf_size equ 4096

section .bss
   input_buffer resb buf_size

;  M A I N  E N T R Y  P O I N T
;  =============================
section .text
global _start
_start:
   call reverseInputLines  ; calling reversal function 

   mov ebx, 0              ; exit code
   mov eax, 0x01           ; syscall
   int 0x80                ; interrupt
   
%include "readLine.asm"

%include "reverseInputLines.asm"
