use crate::bsp::config::*;
use crate::bsp::outb;
use crate::bsp::putchar;
use core::fmt::{self, Write};

pub fn serial_port_init() {
    outb((SERIAL_PORT + 3) as *mut usize, 0b10000011);
    outb((SERIAL_PORT + 1) as *mut usize, 0x00);
    outb((SERIAL_PORT + 0) as *mut usize, 0x01);
    outb((SERIAL_PORT + 3) as *mut usize, 0b00000011);
}

struct Stdout;

impl Write for Stdout {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        for c in s.chars() {
            putchar(c as usize);
        }
        Ok(())
    }
}

pub fn print(args: fmt::Arguments) {
    Stdout.write_fmt(args).unwrap();
}

/// Print! to the host console using the format string and arguments.
#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::bsp::console::print(format_args!($fmt $(, $($arg)+)?))
    }
}

/// Println! to the host console using the format string and arguments.
#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::bsp::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?))
    }
}
