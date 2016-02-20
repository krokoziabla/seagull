.syntax unified

.global __hard_fault_vector
.global __svcall_vector
.global __systick_vector

.thumb_func
__hard_fault_vector:
    bx      lr

.thumb_func
__svcall_vector:
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

