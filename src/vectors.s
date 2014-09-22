.section vectors, "a"

.long __system_stack            // 0 - Main stack pointer
.long __reset_vector            // 1 - Reset
.long 0
.long __hard_fault_vector       // 3 - Hard Fault
