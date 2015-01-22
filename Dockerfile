FROM l3iggs/archlinux-aur
MAINTAINER l3iggs <l3iggs@live.com>

# set number of build cores
USER root
RUN echo MAKEFLAGS="-j`nproc`" >> /etc/makepkg.conf
USER docker

# fix for broken package in AUR
RUN mkdir ~/x264
WORKDIR ~/x264
RUN curl https://aur.archlinux.org/packages/mi/mingw-w64-x264/PKGBUILD > PKGBUILD
RUN sed -i 's,source=(git://git\.videolan\.org/x264\.git#commit=aff928d2),source=(git://git\.videolan\.org/x264\.git#commit=ea0ca51e94323318b95bd8b27b7f9438cdcf4d9e),g' PKGBUILD
RUN makepkg -s --noconfirm
RUN sudo pacman -U --noconfirm mingw-w64-x264-*
WORKDIR /

# enable multilib
USER root
RUN echo "[multilib]" >> /etc/pacman.conf
RUN echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
RUN pacman -Suy --noconfirm
USER docker

#install ffmpeg then remove anything unneeded
RUN yaourt -Suya --noconfirm --needed mingw-w64-ffmpeg
# RUN pacman -Rsn --noconfirm $(pacman -Qdtq)

USER root
# disable multilib
RUN head -n -2 /etc/pacman.conf > /etc/pacman.conf.new && mv /etc/pacman.conf.new /etc/pacman.conf
RUN pacman -Suy --noconfirm

# unset number of cores in makepkg
RUN head -n -1 /etc/makepkg.conf > /etc/makepkg.conf.new && mv /etc/makepkg.conf.new /etc/makepkg.conf
USER docker
