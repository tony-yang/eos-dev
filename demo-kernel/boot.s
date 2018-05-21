/* Declare constants for the multiboot header.*/
.set ALIGN, 1<<0 # align loaded modules on page boundaries
.set MEMINFO, 1<<1 # provide memory map
.set FLAGS, ALIGN | MEMINFO # this is the Multiboot 'flag' field
.set MAGIC, 0x1BADB002 # 'magic number' lets bootloader find the header
.set CHECKSUM, -(MAGIC + FLAGS) # checksum of above, to prove we are multiboot

/*
Declare a multiboot header that marks the program as a kernel.
These are magic values that are documented in the multiboot standard.
The bootloader will search for this signature in the first 8 KB of the kernel
file, aligned at a 32-bit or 4-byte boundary. The signature is in its own section
so the header can be forced to be within the first 8 KB of the kernel file.
*/
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/* The stack, 16-byte aligned for x86 */
.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KB
stack_top:

/* _start is the entry point to the kernel. The bootloader will jump to here and not returned */
.section .text
.global _start
.type _start, @function
_start:
  /* Loaded into 32-bit protected mode on a x86 machine. Basically full control of the hardware
     with no standard library function */

  /* Set up the stack point (esp), x86 stack goes downwards */
  mov $stack_top, %esp

  /* Initialize crucial processor state before the high-level kernel is enterd. */

  /* Enter the high-level kernel */
  call kernel_main

  /* Put the computer into an infinite loop
     1) Disable interrupts with cli
     2) Wait for the next interrupt to arrive with hlt (whould should not happen)
     3) In case 2) happened, jump to the hlt instruction due to non-maskable interrupt or system management mode
  */
  cli
1:hlt
  jmp 1b

/* Set the size of the _start symbol to the current location '.' minus its start.
   Useful for debugging or when implement call tracing
*/
.size _start, . - _start
