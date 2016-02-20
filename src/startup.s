.syntax unified

.global __reset_vector

.thumb_func
__reset_vector:
    bl      schedule
    b       .
