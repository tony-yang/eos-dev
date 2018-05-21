# eos-dev
The eOS development environment

This is an experimental OS development environment. Currently, it includes the i686-elf GCC cross-platform compiler built from the eos-xcompiler Docker image and is targeted for only general i686 OS development. This Docker image does not include any OS source code. To start developing, clone a OS source code from a repository or start from scratch.

## User Guide
After starting a new container, clone a OS repository and start developing.
```
docker build -t eos-dev .
docker run -itd --rm eos-dev
docker exec -it <CONTAINER NAME> bash
git clone <OS repository>
```

## A Hello World Demo Kernel
The demo-kernel directory contains a hello world kernel I used to test the environment setup. The demo follows the Bare Bones tutorial from the osdev.org. I added a few steps not in the tutorial in order to run the demo kernel. All changes are documented here or are automated as part of the environment setup.

- Added additional packages. All packages installed are documented in the Dockerfile
- Run qemu in curses mode (No graphical support inside a docker container)
```
qemu-system-i386 -curses -cdrom eos.iso
```

## References
Download the GRUB source code: ftp://ftp.gnu.org/gnu/grub/grub-2.02.tar.gz

OS Dev Guide: https://wiki.osdev.org/Bare_Bones
