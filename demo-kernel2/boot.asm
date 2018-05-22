; Kernel's entry point. Setup stack or other setting and call main
; Interrupts are disabled at this point
[BITS 32]
global start
start:
  mov esp, _sys_stack ; This points the stack to our new stack area
  jmp stublet

; This part must be 4-byte aligned so we use 'ALIGN 4'
ALIGN 4
mboot:
  ; Multiboot macros to make a few lines later more readable
  MULTIBOOT_PAGE_ALIGN equ 1<<0
  MULTIBOOT_MEMORY_INFO equ 1<<1
  MULTIBOOT_HEADER_MAGIC equ 0x1BADB002
  MULTIBOOT_HEADER_FLAGS equ MULTIBOOT_PAGE_ALIGN | MULTIBOOT_MEMORY_INFO
  MULTIBOOT_CHECKSUM equ -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)

  ; This is the GRUB multiboot header. A boot signature
  dd MULTIBOOT_HEADER_MAGIC
  dd MULTIBOOT_HEADER_FLAGS
  dd MULTIBOOT_CHECKSUM

; A call to main (the C kernel) followed by an infinite loop (jmp $)
stublet:
  EXTERN cmain ; start of our kernel
  call cmain
  jmp $

; Here is the definition of our BSS section.
SECTION .bss
  resb 8192 ; This reserves 8KB of memory here
_sys_stack:
