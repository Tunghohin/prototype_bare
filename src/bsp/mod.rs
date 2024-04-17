pub mod config;
pub mod console;

use config::*;

pub fn init() {
    console::serial_port_init();
}

#[inline(always)]
fn inb(addr: *mut usize) -> u8 {
    unsafe { (addr as *mut u8).read_volatile() }
}

#[inline(always)]
fn outb(addr: *mut usize, data: u8) {
    unsafe {
        (addr as *mut u8).write_volatile(data);
    }
}

#[inline(always)]
pub fn putchar(c: usize) {
    while (inb((SERIAL_PORT + 5) as *mut usize) & 0b01000000) == 0 {}
    outb(SERIAL_PORT as *mut usize, c as u8);
}
