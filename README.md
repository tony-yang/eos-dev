# eos-dev
The eOS development environment

This is an experimental OS development environment. Currently, it includes the i686-elf GCC cross-platform compiler built from the eos-xcompiler Docker image and is targeted for only general i686 OS development. This Docker image does not include any OS source code. To start developing, clone a OS source code from a repository or start from scratch.

## User Guide
After starting a new container, clone a OS repository and start developing.
```
docker build -t eos-dev .
docker run -itd --rm -v <HOST VOLUME>:eos-output eos-dev
docker exec -it <CONTAINER NAME> bash
git clone <OS repository>
```

## A Hello World Demo Kernel
The demo-kernel directory contains a hello world kernel I used to test the environment setup. The demo follows the Bare Bones tutorial from the osdev.org. I added a few steps not in the tutorial in order to run the demo kernel. All changes are documented here or are automated as part of the environment setup.

- Added additional packages. All packages installed are documented in the Dockerfile
- Run qemu in curses mode (No graphical support inside a docker container)
```
docker exec -it <CONTAINER NAME> bash
git clone https://github.com/tony-yang/eos-dev.git
cd eos-dev/demo-kernel
make clean
make
qemu-system-i386 -curses -cdrom bin/eos.iso
```

## Hello World Demo Kernel 2
This demo is almost identical to the previous demo. It also prints hello world. However, it uses the NASM assembler instead of the GCC assembler. Also, it has a slightly different and a more organized structure.


## Real Hardware Testing
Run `make iso-output`. This copies the `eos.iso` to the container's mount point. On the host machine, go to the `<HOST VOLUME>`
```
diskutil list
sudo umount /dev/<DISK IDENTIFIER>
sudo dd if=eos.iso of=/dev/<DISK IDENTIFIER>
diskutil eject /dev/<DISK IDENTIFIER>
```
Note: make sure to use the first identifier of the USB section such as disk1, not the identifier with s1 or s2 such as disk1s1

## References
Download the GRUB source code: ftp://ftp.gnu.org/gnu/grub/grub-2.02.tar.gz

OS Dev Guide: https://wiki.osdev.org/Bare_Bones

Forum discussion on QEMU using BIOS boot when host uses EFI boot, and the solution to `Boot failed: Could not read from CDROM (code 0009)`: https://forum.osdev.org/viewtopic.php?f=1&t=28894

A tutorial shows the potential need for the magic number 0xAA55 at the location 511 and 512. This caused problem to someone on StackExchange. Just take a note for future reference here: http://www.independent-software.com/writing-your-own-bootloader-for-a-toy-operating-system-2/
https://stackoverflow.com/questions/41911606/bootloader-works-in-emulators-but-not-on-real-hardware

Second OS kernel demo tutorial: https://www.cs.vu.nl/~herbertb/misc/writingkernels.txt
