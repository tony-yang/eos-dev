/* The bootloader will look at this image and start execution at the symbol designated as the entry point */
ENTRY(_start)

/* Tell where the various sections of the object files will be put in the final kernel image */
SECTIONS
{
  /* Put sections at 1MB, conventional place for kernels to be loaded at by the bootloader */
  . = 1M;

  /* First put the multiboot header, as it is required to be put very early in the image */
  .text BLOCK(4K) : ALIGN(4K)
  {
    *(.multiboot)
    *(.text)
  }

  /* Read only data */
  .rodata BLOCK(4K) : ALIGN(4K)
  {
    *(.rodata)
  }

  /* Read write data (initialized) */
  .data BLOCK(4K) : ALIGN(4K)
  {
    *(.data)
  }

  /* read write data (uninitialized) and stack */
  .bss BLOCK(4K) : ALIGN(4K)
  {
    *(COMMON)
    *(.bss)
  }
}
