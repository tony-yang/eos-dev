# eOS Dev Environment
#
# VERSION 0.1

FROM eos-xcompiler
RUN apt-get update && apt-get install -y \
    gettext \
    git \
    grub-pc-bin \
    libfreetype6-dev \
    mtools \
    qemu \
    qemu-system-x86 \
    ttf-unifont \
    vim \
    xorriso \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root

COPY config/vimrc /root/.vimrc
COPY config/gitconfig /root/.gitconfig

ENV HOME="/root" \
    PREFIX="/root/opt/grub" \
    TARGET=i686-elf \
    PATH="/root/opt/grub/bin:$PATH" \
    SRC="/root/src"

RUN mkdir -p ${SRC} \
 && mkdir -p ${PREFIX} \
 && cd ${SRC} \
 && wget ftp://ftp.gnu.org/gnu/grub/grub-2.02.tar.gz \
 && tar -zxf ${SRC}/grub-2.02.tar.gz \
 && mkdir build-grub \
 && cd build-grub \
 && ../grub-2.02/configure --prefix="${PREFIX}" --target=${TARGET} --with-platform=efi \
 && make \
 && make install \
 && make clean \
 && cd ${SRC} \
 && rm -rf grub-2.02.tar.gz grub-2.02

CMD ["bash"]
