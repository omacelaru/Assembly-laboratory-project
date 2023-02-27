# 133_Macelaru_OctavianAndrei_0.s
.data
    matrice: .space 40000
    m1: .space 40000
    m2: .space 40000
    mres: .space 40000
    legaturi: .space 400
    n: .space 4
    np: .space 4
    x: .space 4
    k: .space 4
    t: .space 4
    p1: .space 4
    p2: .space 4
    cerinta: .space 4
    formatScanf3: .asciz "%d%d%d"
    formatPrintf: .asciz "%d"
    formatPrintfLinie: .asciz "%d "
    formatScanf: .asciz "%d"
    endl: .asciz "\n"
.text
matrix_mult:
    pushl %ebp
    mov %esp, %ebp
    
    pushl %ebx
    pushl %esi
    pushl %edi
    
    lea 8(%ebp), %eax # %esi contine m1
    mov (%eax), %esi
    
    lea 12(%ebp), %eax # %edi contine m2
    mov (%eax), %edi
    
    subl $12, %esp
    
    # %ecx pt i
    # %eax pt j
    # %ebx pt k
    xorl %ecx, %ecx
    for_i_p:
        cmp 20(%ebp), %ecx
        jge exit_p
    
        xorl %eax, %eax
        for_j_p:
            cmp 20(%ebp), %eax
            jge cont_i
    
            # -4(ebp) = ecx * 20(ebp) + eax
            push %eax
            push %ebx
            push %ecx
    
            mov %eax, %ebx
            mov 20(%ebp), %eax
            mul %ecx
            add %ebx, %eax
    
            mov %eax, -4(%ebp)
    
            xorl %ecx, %ecx
    
            push %edi
            push %eax
            lea 16(%ebp), %eax
            mov (%eax), %edi
    
            mov -4(%ebp), %edx
            mov %ecx, (%edi, %edx, 4)
    
            pop %eax
            pop %edi
    
            pop %ecx
            pop %ebx
            pop %eax
    
            xorl %ebx, %ebx
            
            for_k_p:
                cmp 20(%ebp), %ebx
                jge cont_j
    
                # -8(ebp) = ecx * 20(ebp) + ebx
                push %eax
                push %ebx
                push %ecx
    
                mov 20(%ebp), %eax
                mul %ecx
                add %eax, %ebx
    
                mov %ebx, -8(%ebp)
    
                pop %ecx
                pop %ebx
                pop %eax
    
                # -12(ebp) = ebx * 20(ebp) + eax
                push %eax
                push %ebx
                push %ecx
    
                mov %eax, %ecx
                mov 20(%ebp), %eax
                mul %ebx
                add %ecx, %eax
    
                mov %eax, -12(%ebp)
    
                pop %ecx
                pop %ebx
                pop %eax
    
                pusha
                mov -12(%ebp), %ecx
                mov (%edi, %ecx ,4), %eax
    
                mov -8(%ebp), %ecx
                mov (%esi, %ecx,4), %ebx
    
                mull %ebx
    
                mov -4(%ebp), %ecx
                push %edi
                push %eax
    
                lea 16(%ebp), %edx
                mov (%edx), %edi
    
                mov (%edi, %ecx, 4), %ebx
    
                add %ebx, %eax
    
                mov -4(%ebp), %ecx
                mov  %eax, (%edi, %ecx, 4)
                pop %eax
                pop %edi
    
                popa
    
                inc %ebx
                jmp for_k_p
    
            cont_j:
    
                inc %eax
                jmp for_j_p
        cont_i:
            inc %ecx
            jmp for_i_p
    
    exit_p:
    addl $12, %esp
    
    popl %edi
    popl %esi
    popl %ebx
    popl %ebp
    ret
.global main
main:
    # citire numar cerinta
    pusha
    pushl $cerinta
    pushl $formatScanf
    call scanf
    pop %edx
    pop %edx
    popa
    
    movl cerinta, %eax
    cmp $1, %eax
    je cerinta_1
 
cerinta_1:
    pusha
    pushl $n
    pushl $formatScanf
    call scanf
    pop %edx
    pop %edx
    popa
    
    movl n, %eax
    mull n
    movl %eax, np
    
    initializare_0:
    lea matrice, %esi
    xorl %ecx, %ecx
    for_i:
        cmp n, %ecx
        jge cont
        
        xorl %ebx, %ebx
        for_j:
            cmp n, %ebx
            jge next_for_i
    
            movl %ecx, %eax
            mull n
    
            add %ebx, %eax
    
            xorl %edx, %edx
            mov %edx, (%esi,%eax,4)
    
            inc %ebx
            jmp for_j
        next_for_i:
            inc %ecx
            jmp for_i
    
    cont:
    lea legaturi, %edi
    xorl %ecx, %ecx
    for_legaturi:
        cmp n, %ecx
        jge continuare
    
        pusha
        push $x
        pushl $formatScanf
        call scanf
        pop %edx
        pop %edx
        popa
    
        movl x, %eax
        movl %eax, (%edi, %ecx, 4)
    
        inc %ecx
        jmp for_legaturi
    
    continuare:
    xorl %ecx, %ecx
    for_a:
        cmp n, %ecx
        jge continuare_verificare
        movl (%edi, %ecx, 4), %eax
        mov %eax, k
            xorl %ebx, %ebx
            for_adiacenta:
                cmp k, %ebx
                jge next_for_adiacenta
    
                pusha
                push $x
                pushl $formatScanf
                call scanf
                pop %edx
                pop %edx
                popa
    
                movl %ecx, %eax
                mull n
    
                addl x, %eax
    
                movl $1, %edx
                mov %edx, (%esi, %eax, 4)
    
                inc %ebx
                jmp for_adiacenta
    
            next_for_adiacenta:
                inc %ecx
                jmp for_a
    
    continuare_verificare:
        movl cerinta, %eax
        cmp $2, %eax
        je cerinta_2
    afisare:
        xorl %ecx, %ecx
        for_i_af:
            cmp n, %ecx
            jge exit
    
            xorl %ebx, %ebx
            for_j_af:
                cmp n, %ebx
                jge next_for_i_af
    
                movl %ecx, %eax
                mull n
    
                add %ebx, %eax
    
                mov (%esi, %eax, 4), %edx
                mov %edx, x
        
                pusha
                pushl x
                pushl $formatPrintfLinie
                call printf
                pop %edx
                pop %edx

                pushl $0
                    call fflush
                    popl %ebx
                popa
    
                inc %ebx
                jmp for_j_af
    
            next_for_i_af:
                pusha
                    movl $4, %eax
                    movl $1, %ebx
                    movl $endl, %ecx
                    movl $1, %edx
                    int $0x80
                popa
    
    
                inc %ecx
                jmp for_i_af
    
cerinta_2:
    pusha
    pushl $p2
    pushl $p1   
    pushl $t
    pushl $formatScanf3
    call scanf
    pop %edx
    pop %edx
    pop %edx
    pop %edx
    popa
    
    xorl %ecx, %ecx
    lea m1, %edi
    for_copiere_m1:
        cmp np, %ecx
        jge c1
    
        mov (%esi, %ecx, 4), %eax
        mov %eax, (%edi, %ecx, 4)
    
        inc %ecx
        jmp for_copiere_m1
    
    c1:
    xorl %ecx, %ecx
    lea mres, %edi
    for_copiere_mres:
        cmp np, %ecx
        jge continuare_2
    
        mov (%esi, %ecx, 4), %eax
        mov %eax, (%edi, %ecx, 4)
    
        inc %ecx
        jmp for_copiere_mres
    
    continuare_2:
    decl t
    xorl %ecx, %ecx
    for_inmultire:
        cmp t, %ecx
        jge afi
    
        # copierea matricei mres in m2 pentru apelare
        push %ecx
    
        xorl %ecx, %ecx
        lea mres, %esi
        lea m2, %edi
        for_copiere_m2:
            cmp np, %ecx
            jge c2
    
            mov (%esi, %ecx, 4), %eax
            mov %eax, (%edi, %ecx, 4)
    
            inc %ecx
            jmp for_copiere_m2
 
        c2:
        pop %ecx
    
        pusha
    
        pushl n
        pushl $mres
        pushl $m2
        pushl $m1
        call matrix_mult
        pop %edx
        pop %edx
        pop %edx
        pop %edx
        popa
    
        inc %ecx
        jmp for_inmultire
 
   afi:
        pusha
        mov p1, %eax
        mull n
        addl p2, %eax
    
        lea mres, %esi
        mov (%esi, %eax, 4), %ebx
    
        push %ebx
        pushl $formatPrintf
        call printf
        pop %edx
        pop %edx

        pushl $0
        call fflush
        popl %ebx
        popa
        popa
exit:
   mov $1, %eax
   xorl %ebx, %ebx
   int $0x80
   
