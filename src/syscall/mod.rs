mod fs;

use fs::sys_write;

const SYSCALL_WRITE: usize = 64;

pub fn syscall(syscall_id: usize, args: [usize; 3]) -> isize {
    match syscall_id {
        SYSCALL_WRITE => sys_write(args[0], args[1] as *const u8, args[2]),
        _ => {
            panic!("Unsupported syscall: ID = {}", syscall_id);
        }
    }
}
