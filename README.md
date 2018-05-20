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

## References
Download the GRUB source code: ftp://ftp.gnu.org/gnu/grub/grub-2.02.tar.gz

OS Dev Guide: https://wiki.osdev.org/Bare_Bones
