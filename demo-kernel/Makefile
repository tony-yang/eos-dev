CC_AS := i686-elf-as

CC := i686-elf-gcc
CC_OPTIONS := -std=gnu99 -ffreestanding -O2 -Wall -Wextra

CC_LINK := i686-elf-gcc
CC_LINK_OPTIONS := -ffreestanding -O2 -nostdlib -lgcc
OBJS_DIR := bin
LINK_OBJ = $(wildcard $(OBJS_DIR)/*.o)

ISO_DIR := isodir
ISO_DIR_BOOT := $(ISO_DIR)/boot


all: $(OBJS_DIR) eos.bin verify eos.iso

boot.o: $(OBJS_DIR)
	$(CC_AS) boot.s -o $(OBJS_DIR)/$@

kernel.o: $(OBJS_DIR)
	$(CC) -c kernel.c -o $(OBJS_DIR)/$@ $(CC_OPTIONS)

eos.bin: boot.o kernel.o
	$(CC_LINK) -T linker.ld -o $(OBJS_DIR)/$@ $(CC_LINK_OPTIONS) $(LINK_OBJ)

verify: eos.bin
	grub-file --is-x86-multiboot $(OBJS_DIR)/$<

eos.iso: eos.bin verify
	cp $(OBJS_DIR)/eos.bin $(ISO_DIR_BOOT)
	grub-mkrescue -d /usr/lib/grub/i386-pc -o $(OBJS_DIR)/$@ $(ISO_DIR)

$(OBJS_DIR):
	mkdir $(OBJS_DIR)

clean:
	rm -rf $(OBJS_DIR)
	rm -rf $(ISO_DIR_BOOT)/*.bin
