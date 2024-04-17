const FD_STDIN: usize = 0;
const FD_STDOUT: usize = 1;

pub fn sys_write(fd: usize, buf: *const u8, len: usize) -> isize {
    match fd {
        FD_STDOUT => unsafe {
            crate::print!(
                "{}",
                core::str::from_utf8_unchecked(core::slice::from_raw_parts(buf, len))
            );
        },
        _ => {
            panic!("Unsupported fd in sys_write!");
        }
    }
    0
}
