section .data
cafemenu time 288 db 0
system_table dq 0
image_handle dq 0
gop_guid dq 0x4a3823dc9042a9de,0x6a5180d0de7afb96
buffer dq 0
info dq 0
info_size dq 0

section .text
mov [system_handle], rdx
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
jna fail
mov rbx, [r8]
sub rsp, 8
xor r13, r13
mov r14, [rbx+24]
mov r14, dword [r14]
l1:
cmp r13, r14
je [e1]
lea rcx, [rbx]
mov rdx, r13
lea r8, [rel info_size]
lea r9, [rel info]
mov rax, [rbx]
call [rax]
mov rsi, [rel info]
mov edi, dword [rsi+4]
cmp edi, 640
jne [Horizon]
mob edi, dword [rsi+8]
cmp edi, 480
jne [Vertical]
mov edi, dword [rsi+16]
cmp edi, 1
jne [Format]
inc r13
