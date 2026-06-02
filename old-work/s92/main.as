section .data
cafemenu time 288 db 0
system_table dq 0
image_handle dq 0
gop_guid dq 0x4a3823dc9042a9de,0x6a5180d0de7afb96
buffer dq 0
info dq 0
info_size dq 0

section .text
mov [system_table], rdx
mov [image_handle], rcx
mov r13, rdx
mov r13, [r13+0x58]
mov rax, [r13+0x27] ;locate_protocol
mov rcx, [rel gop_guid]
xor rdx, rdx
lea r8, [rel buffer]
sub rsp, 40
call [rax]
;add rsp, 40
cmp rax, 0
jne [fail]
mov rbx, [r8]
sub rsp, 8
xor r13, r13
mov r14, [rbx+24]
mov r14, dword [r14]
.gop_slf:
cmp r13, r14
je [.gop_slf_end_after]
lea rcx, [rbx]
mov rdx, r13
lea r8, [rel info_size]
lea r9, [rel info]
mov rax, [rbx]
call [rax]
mov rsi, [rel info]
mov edi, dword [rsi+4]
cmp edi, 640
jne [.Horizon]
mov edi, dword [rsi+8]
cmp edi, 480
jne [.Vertical]
mov edi, dword [rsi+16]
cmp edi, 1
jne [.Format]
jmp [.gop_slf_end]
.Horizon:
inc r13
jmp [.gop_slf]
.Vertical:
inc r13
jmp [.gop_slf]
.Format:
inc r13
jmp [.gop_slf]
.gop_slf_after:

