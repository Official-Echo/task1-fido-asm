	mov     rcx, qword ptr [rcx]
	test    rcx, rcx
	je      .LBB2_8
	mov     rax, qword ptr [rcx]
	test    rax, rax
	je      .LBB2_8
	mov     r9, qword ptr [rax]
	test    r9, r9
	je      .LBB2_9
	mov     r10, -2
	mov     r8d, 3
	movabs  r11, -6148914691236517205
	jmp     .LBB2_5
.LBB2_4:
	mov     r9, qword ptr [r9]
	dec     r10
	inc     r8
	test    r9, r9
	je      .LBB2_9
.LBB2_5:
	mov     rax, r8
	mul     r11
	shr     rdx
	lea     rax, [rdx + 2*rdx]
	add     rax, r10
	je      .LBB2_4
	mov     rcx, qword ptr [rcx]
	test    rcx, rcx
	jne     .LBB2_4
.LBB2_8:
	xor     ecx, ecx
.LBB2_9:
	mov     rax, rcx
	ret
