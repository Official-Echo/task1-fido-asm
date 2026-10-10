 	mov res_ptr, qword ptr [list_ptr]      ; list.head
    test res_ptr, res_ptr                  ; head null?
    je return_none                         ; if yes, return none
    mov sec_node, qword ptr [res_ptr]      ; if no, go ahead, head.next
    test sec_node, sec_node                ; head.next null?
    je return_none                         ; if yes, return none
    mov curr_node, qword ptr [sec_node]    ; if no, go ahead, head.next.next
    test curr_node, curr_node              ; head.next.next null?
    je return_res                          ; if yes, then length is 2, return first element
    mov neg_len, -2                        ; -len accumulator
    mov len, 3                             ; len = 3
    movabs magic_three, -6148914691236517205 ; reciprocal fixed-point constant, 2^64/3
    jmp check_modulo                       ; enter loop
step_curr:
    mov curr_node, qword ptr [curr_node]   ; curr = curr.next
    dec neg_len                            ; neg_len -= 1
    inc len                                ; len += 1
    test curr_node, curr_node              ; curr null?
    je return_res                          ; if yes, no elements left, returning res
check_modulo:
    mov scratch, len                       ; scratch = len
    mul magic_three                        ; rdx:rax = len * magic_three
    shr rdx                                ; rdx = len / 3 by u_int division
    lea scratch, [rdx + 2*rdx]             ; scratch = rdx + 2 * rdx
    add scratch, neg_len                   ; scratch = 3 * (len / 3) - (len - 1)
    je step_curr                           ; if scratch == 0, then len % 3 == 1, skip advance
    mov res_ptr, qword ptr [res_ptr]       ; res = res.next
    test res_ptr, res_ptr                  ; res null?
    jne step_curr                          ; .next
return_none:
    xor res_ptr, res_ptr                   ; return null
return_res:
    mov return_reg, res_ptr                ; return res
    ret                                    ; return