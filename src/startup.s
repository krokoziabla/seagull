.syntax unified

.global __reset_vector

.thumb_func
__reset_vector:

    # lauch scheduler
    ldr     r0, =init
    bl      schedule

    b       .
