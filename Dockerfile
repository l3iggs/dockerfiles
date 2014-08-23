FROM base/devel:latest
MAINTAINER l3iggs <l3iggs@live.com>

RUN echo MAKEFLAGS="-j`nproc`" >> /etc/makepkg.conf


RUN echo "[multilib]" >> /etc/pacman.conf
RUN echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
RUN pacman -Suy --noconfirm

RUN yaourt -Sa --noconfirm mingw-w64-ffmpeg
