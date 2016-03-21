FROM ubuntu:14.04
MAINTAINER Qian Hong <qhong@codeweavers.com>
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:wine/wine-builds
RUN apt-get update && apt-get install -y --install-recommends wine-staging winehq-staging winetricks wget xvfb winbind fonts-droid attr && apt-get clean -y
RUN apt-get install -y language-pack-en-base language-pack-en && apt-get clean -y
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TERM xterm
ENV CYGWIN winsymlinks:lnk
# Work around https://bugs.wine-staging.com/show_bug.cgi?id=626
ENV WINPTY_SHOW_CONSOLE 1
COPY cygwin32-env /etc/
COPY cygwin-shell /usr/bin/
COPY cygwin-rebase /usr/bin/
COPY cygwin32-init /usr/bin/
COPY cygwin32 /usr/bin/
RUN cygwin32-init
RUN cygwin32 -c cp -f /usr/bin/false /usr/bin/tput
RUN cygwin-rebase
