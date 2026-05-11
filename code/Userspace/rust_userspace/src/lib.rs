// main is treated as an executable, library can be compiled to raw binary

// no standard rust library and no main function tag
#![no_std]
#![no_main]

// importing the panic info strucct form the core library
// the default target compiler provides this
use core::panic::PanicInfo;

// compiler change the name of the functuon to something random 
// no_mangle makes it so that hte name of the function doesnt change
#[unsafe(no_mangle)] 

// making the non return funtion available to the linker
// using the C calling convention that makes sure that the stack and register
// remain same for the program and handing n infinte loop to stop garbage execution
pub extern "C" fn user_main() -> ! {
    loop {}
}

// cpu jumps here and executes this loop if the code crashes in the userspace
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
