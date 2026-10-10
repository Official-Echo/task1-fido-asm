	default rel

	%ifidn  __OUTPUT_FORMAT__, elf64
%define arg1 rdi
%else
%define arg1 rcx
%endif

global get_two_thirds_node
section .text

get_two_thirds_node:
	mov     rcx, [arg1]
	test    rcx, rcx
	jz      return_none
	mov     rax, [rcx]
	test    rax, rax
	jz      return_none
	mov     r9, [rax]
	test    r9, r9
	jz      return_res
	mov     r10, -2
	mov     r8, 3
	mov     r11, -6148914691236517205
	jmp     check_modulo

step_curr:
	mov     r9, [r9]
	dec     r10
	inc     r8
	test    r9, r9
	jz      return_res

check_modulo:
	mov     rax, r8
	mul     r11
	shr     rdx, 1
	lea     rax, [rdx + 2*rdx]
	add     rax, r10
	jz      step_curr
	mov     rcx, [rcx]
	test    rcx, rcx
	jnz     step_curr

return_none:
	xor     ecx, ecx
return_res:
	mov     rax, rcx
	ret

	%ifidn  __OUTPUT_FORMAT__, elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif