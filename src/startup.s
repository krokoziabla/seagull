.syntax unified

.global __reset_vector

.thumb_func
__reset_vector:

    # lauch scheduler
    ldr     r0, =init
    mov     r1, #25
    svc     #0

    b       .
