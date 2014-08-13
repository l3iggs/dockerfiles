FROM base/devel:latest
MAINTAINER l3iggs <l3iggs@live.com>

# setup the generic build environment, grab the source code
RUN pacman -Suy --noconfirm
RUN git config --global user.email "l3iggs@live.com"
RUN git config --global user.name "l3iggs"

# install mercurial cmake and unzip
RUN pacman -Suy --noconfirm mercurial cmake unzip

#list installed packages
RUN pacman -Q

RUN git clone https://github.com/pyke369/sffmpeg.git
WORKDIR /sffmpeg
CMD git pull && /
make
