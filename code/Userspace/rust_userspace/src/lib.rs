#![no_std]
#![no_main]

use core::panic::PanicInfo;

#[unsafe(no_mangle)] 
pub extern "C" fn user_main() -> ! {
    loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}