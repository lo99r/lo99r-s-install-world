section .data
cafemenu: times 288 db 0
system_table dq 0
image_handle dq 0
gop_guid dq 0x4a3823dc9042a9de,0x6a5180d0de7afb96
rsdp_guid dq 0x11d324f18868e871,0x81883cc7800022bc
buffer dq 0
info dq 0
info_size dq 0
rsdp dq 0

section .text
mov [system_table], rdx
mov [image_handle], rcx
mov r13, rdx
mov r13, [r13+0x58]
mov rax, [r13+0x140] ;locate_protocol
lea rcx, [rel gop_guid]
xor rdx, rdx
lea r8, [rel buffer]
sub rsp, 40
call rax
add rsp, 40
cmp rax, 0
jne fail
mov rbx, [rel buffer]
xor r12, r12
mov r14, [rbx+24]
mov r14d, dword [r14]
gop_slf:
cmp r12, r14
je .gop_slf_end_after
mov rcx, rbx
mov rdx, r12
lea r8, [rel info_size]
lea r9, [rel info]
mov rax, [rbx]
sub rsp, 40
call rax
add rsp, 40
test rax, rax
jnz .next
inc r12
jmp gop_slf
.next:
mov rsi, [rel info]
mov edi, dword [rsi+4]
cmp edi, 640
jne .Horizon
mov edi, dword [rsi+8]
cmp edi, 480
jne .Vertical
mov edi, dword [rsi+16]
cmp edi, 1
jne .Format
jmp .gop_slf_end
.Horizon:
inc r12
jmp gop_slf
.Vertical:
inc r12
jmp gop_slf
.Format:
inc r12
jmp gop_slf
.gop_slf_end_after:
mov rcx, [image_handle]
xor rdx, rdx
xor r8, r8
xor r9, r9
lea rax, [r13+0xD8]
call rax
hlt
.gop_slf_end:
mov rax, [rbx+8]
mov rcx, rbx
mov rdx, r12
sub rsp, 40
call rax
add rsp, 40
test rax, rax
jnz .gop_slf_end_after
get_rsdp:

