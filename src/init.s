.syntax unified

.global init

# name:
#   init
# desc:
#   root thread
# in:
#   none
# out:
#   r0 - result code
.thumb_func
init:
    mov     r0, #0
    bx      lr
