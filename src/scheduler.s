.syntax unified

.global scheduler_thread_preempted

.lcomm ready_first, 4
.lcomm ready_last_but_one, 4

scheduler_thread_preempted:
    bx      lr
