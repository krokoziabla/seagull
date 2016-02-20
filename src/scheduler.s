.syntax unified

.global schedule

# name:
#   schedule
# desc:
#   launches scheduler
# in:
#   r0 - the entry point (an address) to the root thread
# out:
#   r0 - the return code of root thread
.thumb_func
schedule:
    push    {r4-r11, lr}

    # call root thread
    blx     r0

    pop     {r4-r11, lr}
    bx      lr
