FROM l3iggs/archlinux
MAINTAINER l3iggs <l3iggs@live.com>

# setup the generic build environment, grab the source code
RUN pacman -Suy --noconfirm --needed git base-devel
RUN git config --global user.email "l3iggs@live.com"
RUN git config --global user.name "l3iggs"

# install mercurial cmake and unzip
RUN pacman -Suy --noconfirm mercurial cmake unzip

RUN git clone https://github.com/pyke369/sffmpeg.git
WORKDIR /sffmpeg
CMD git pull && \
make
