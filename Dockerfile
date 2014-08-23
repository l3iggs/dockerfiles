FROM base/devel:latest
MAINTAINER l3iggs <l3iggs@live.com>

RUN echo MAKEFLAGS="-j`nproc`" >> /etc/makepkg.conf

# fix for broken package in AUR
RUN mkdir /x264
WORKDIR /x264
RUN curl https://aur.archlinux.org/packages/mi/mingw-w64-x264/PKGBUILD > PKGBUILD
RUN sed -i 's,source=(git://git\.videolan\.org/x264\.git#commit=aff928d2),source=(git://git\.videolan\.org/x264\.git#commit=ea0ca51e94323318b95bd8b27b7f9438cdcf4d9e),g' PKGBUILD
RUN makepkg -s --asroot --noconfirm
RUN pacman -U --noconfirm mingw-w64-x264-*
WORKDIR /

RUN echo "[multilib]" >> /etc/pacman.conf
RUN echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
RUN pacman -Suy --noconfirm

RUN yaourt -Suya --noconfirm mingw-w64-ffmpeg && yaourt -Qtd 
