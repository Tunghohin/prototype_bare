#![feature(lang_items)]
#![no_std]
#![no_main]

mod bsp;
mod mem;
mod syscall;

use core::arch::global_asm;
use core::panic::PanicInfo;

global_asm!(include_str!("boot.asm"));
#[no_mangle]
pub extern "C" fn rust_main() -> ! {
    bsp::init();
    println!("PingPong!");
    loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    bsp::init();
    loop {}
}
