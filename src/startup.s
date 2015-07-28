.syntax unified

.global __reset_vector

.global scheduler_thread_preempted

.thumb_func
__reset_vector:
    svc     #0
    bl      scheduler_thread_preempted
    b       .
