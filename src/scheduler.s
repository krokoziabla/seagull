.syntax unified

.global shceduler_start
.global shceduler_schedule
.global exit
.global wrapper
.global fork
.global wait

.set systick_base_register, 0xe000e010
.set sysctrl_base_register, 0xe000ed00

# name:
#   wrapper
# desc:
#   enters the new thread's function and calls exit call
#   afterwards
# in:
#   r0 - the entry point (an address) to the root thread
#   r1 - the pointer to the arguments of the root thread
# out:
#   r0 - return code of the root thread
.thumb_func
wrapper:
    mov     r2, r0
    mov     r0, r1
    blx     r2
    svc     #1


# name:
#   shceduler_start
# desc:
#   launches scheduler
# in:
#   r0 - the entry point (an address) to the root thread
#   r1 - the pointer to the arguments of the root thread
# out:
#   r0 - the return code of root thread
.thumb_func
shceduler_start:
    push    {r4-r11, lr}

    # ASSERT: the schedule is not running

    # init app stack for the root process
    ldr     r4, =__app_stack
    #   xPSR
    mov     r5, #0x0000
    movt    r5, #0x0100
    str     r5, [r4, #-0x04]!
    #   PC
    ldr     r2, =wrapper
    str     r2, [r4, #-0x04]!
    #   LR
    movw    lr, #0xffff
    movt    lr, #0xffff
    str     lr, [r4, #-0x04]!
    #   R12, R3-R0
    mov     r5, #0x00
    str     r5, [r4, #-0x04]!
    str     r5, [r4, #-0x04]!
    str     r5, [r4, #-0x04]!
    str     r1, [r4, #-0x04]!
    str     r0, [r4, #-0x04]!

    msr     psp, r4

    # configure and enable SysTick timer
    ldr     r0, =systick_base_register
    mov     r1, #100
    str     r1, [r0, #+0x04]
    str     r1, [r0, #+0x08]
    mov     r1, #0x07
    str     r1, [r0, #+0x00]

    // set LR to 0xffffffd to switch to Thread Process mode
    bfc     lr, #1, #1
    bx      lr

# name:
#   exit
# desc:
#   terminates process
# in:
#   r0 - the return code of the thread
exit:
    # disable SysTick timer
    ldr     r1, =systick_base_register
    mov     r2, #0
    str     r2, [r1, #+0x00]
    # clear pending SysTick interrupt
    ldr     r1, =sysctrl_base_register
    ldrb    r2, [r1, #+0x07]
    orr     r2, #2
    strb    r2, [r1, #+0x07]
    pop     {r4-r11, lr}
    bx      lr

fork:
    bx      lr

wait:
    bx      lr

# name:
#   shceduler_schedule
# desc:
#   schedules next thread to run
# in:
.thumb_func
shceduler_schedule:
    bx      lr
