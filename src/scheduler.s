.syntax unified

.global schedule
.global exit
.global wrapper

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
#   schedule
# desc:
#   launches scheduler
# in:
#   r0 - the entry point (an address) to the root thread
#   r1 - the pointer to the arguments of the root thread
# out:
#   r0 - the return code of root thread
.thumb_func
schedule:
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
    pop     {r4-r11, lr}
    bx      lr
