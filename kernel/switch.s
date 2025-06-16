; kernel/switch.s
section .text
    global get_current_esp
    global task_switch

get_current_esp:
    mov eax, esp      ; Return current stack pointer
    ret

task_switch:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    mov eax, [ebp+8]  ; First argument: old_esp pointer
    mov edx, [ebp+12] ; Second argument: new_esp value

    mov [eax], esp    ; Save current ESP to old_esp
    mov esp, edx      ; Load new ESP

    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
