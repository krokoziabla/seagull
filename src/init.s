.syntax unified

.global init

# name:
#   init
# desc:
#   root thread
# in:
#   r0 - the pointer to the arguments
# out:
#   r0 - return code
.thumb_func
init:
    mov     r0, #5
    bx      lr
