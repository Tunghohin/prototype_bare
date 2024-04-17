pub const KERNEL_STACK_SIZE: usize = 1024;
pub const USER_STACK_SIZE: usize = 1024;
pub const MAX_TASK_NUM: usize = 8;

pub const DEVICE_BASE: usize = 0x10000000;
pub const SERIAL_PORT: usize = DEVICE_BASE + 0x00000000;
