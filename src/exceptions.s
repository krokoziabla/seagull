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

    #   0: schedule
    cmp     r4, #000
    ittt    eq
    ldreq   r0, [r5, #+0x00]
    ldreq   r1, [r5, #+0x04]
    bleq    schedule
    cmp     r4, #000
    itt     eq
    streq   r0, [r5, #+0x00]
    beq     __svcall_handled

    #   1: exit
    cmp     r4, #001
    ittt    eq
    ldreq   r0, [r5]
    popeq   {r4-r11, lr}
    beq     exit

    #   2: vacant

.thumb_func
__svcall_handled:
    pop     {r4-r11, lr}
    bx      lr

# We assume that SysTick has the lowest interrupt priority.
# We need this to be sure that r4-r11 contain values of a thread.
.thumb_func
__systick_vector:
    # save context
    mrs     r0, psp
    stmfd   r0!, {r4-r11}
    msr     psp, r0

    bl      schedule

    # restore context
    mrs     r0, psp
    ldmfd   r0!, {r4-r11}
    msr     psp, r0
    bx      lr

