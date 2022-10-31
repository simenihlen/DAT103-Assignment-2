; R E V E R S I N G
; =================
; void reverse()
; Recursively read in words, until none are found anymore.
; After the recursive calls are done, write out the word again.
reverseInputLines:

  call1_1 edx, readLine, input_buffer

  cmp edx, 0          ; If nothing was read, it means the
  jg there_is_input   ; input is already fully processed, i.e.
  ret                 ; that this call is finished.

there_is_input:
  
  mov eax, esp   ; Original stack pointer
  sub eax, edx   ; Enough space to store the read string

  mov ebx, 3     ; Complement of round-to-multiples-of-4 bitmask
  not ebx   
  and eax, ebx   ; Align stack location to 32-bit
  mov esp, eax   ; Allocate the space on the stack

  mov eax, 0     ; Index into the buffer when copying

push_loop:
  mov ecx, [input_buffer + eax]           ; Legger input_buffer og eax inn i ecx
  mov w32FrStck(esi), ecx                 ; Macro for den mest 'esi'th pushed
  ;push dword ebx                          ; Pusher dword byte til stack
  add eax, 4
  inc esi                                 ; Øker teller
  cmp eax, edx                            ; Sammenligner teller og total karakterer
  jl push_loop                            ; "Jumpwhenless" til det ikke er flere karakterer
  ;push dword eax                          ; Push dword karakterteller til stack
  mov ecx, [input_buffer]
  push edx

  call reverseInputLines                  ; Rekursiv call
  
  pop edx                                 ; Får karakterteller fra stack til å blir brukt som teller
  mov ecx, esp                            ; Lagre karakterteller

  mov eax, SYS_WRITE                      ; Printer ut input
  mov ebx, STDOUT
  int 0x80

  ; Deallokering av input fra minnet
  mov eax, esp                            
  add eax, edx
  add eax, 3
  mov ebx, 3
  not ebx
  and eax, ebx
  mov esp, eax

  ; Klargjøring av input_buffer 
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  mov [input_buffer], byte LINE_SHIFT
  mov ecx, input_buffer
  mov edx, 1
  int 0x80

  ret                                      ; Fikk mye hjelp fra Varnan Jayasooriyan (studid: 598988)

  ;pop dword ecx                           ; Char fra stack
  ;dec eax                                 ; Mink teller
  ;mov [input_buffer + eax], ebx           ; Flytt char til buffer fra register
  ;cmp eax, 0x00                           ; Sammenlign teller til 0
  ;jg pop_loop                             ; Fortsett loopen hvis det er flere karakterer igjen (jumpgreater)

  ;inc edx

  ;mov ecx, input_buffer                   
  ;mov ebx, STDOUT
  ;mov eax, SYS_WRITE
  ;int 0x80

  ;ret
 














