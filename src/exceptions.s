.syntax unified

.global __hard_fault_vector
.global __svcall_vector
.global __systick_vector

.thumb_func
__hard_fault_vector:
    bx      lr

.thumb_func
__svcall_vector:

    # which stack to inspect - SP_main or SP_process?
    mrs     r0, msp
    push    {r4-r11, lr}
    mov     r5, r0
    bfc     lr, #8, #24
    cmp     lr, #0xfd
    it      eq
    mrseq   r5, psp

    # fetch SVC's argument
    ldr     r4, [r5, #+0x18]
    ldrb    r4, [r4, #-0x02]

    # call the appropriate handler
    ldr     r0, =svcalls
    ldr     r0, [r0, r4, lsl #2]
    bx      r0

svcalls:
    .word   svcall_schedule
    .word   svcall_exit
    .word   svcall_fork
    .word   svcall_wait

.thumb_func
svcall_schedule:
    ldr     r0, [r5, #+0x00]
    ldr     r1, [r5, #+0x04]
    bl      shceduler_start
    str     r0, [r5, #+0x00]
    b       svcall_handled

.thumb_func
svcall_exit:
    ldr     r0, [r5]
    pop     {r4-r11, lr}
    b       exit

.thumb_func
svcall_fork:
    bl      fork
    str     r0, [r5, #+0x00]
    b       svcall_handled

.thumb_func
svcall_wait:
    ldr     r0, [r5, #+0x00]
    bl      wait
    str     r0, [r5, #+0x00]
    b       svcall_handled

.thumb_func
svcall_handled:
    pop     {r4-r11, lr}
    bx      lr

# We assume that SysTick has the lowest interrupt priority.
# We need this to be sure that r4-r11 contain values of a thread.
.thumb_func
__systick_vector:
    # save context
    push    {lr}

    mrs     r0, psp
    stmfd   r0!, {r4-r11}
    msr     psp, r0

    bl      shceduler_schedule

    # restore context
    mrs     r0, psp
    ldmfd   r0!, {r4-r11}
    msr     psp, r0

    pop     {lr}
    bx      lr

