FROM teaci/wine-staging
MAINTAINER Qian Hong <qhong@codeweavers.com>
# Work around https://bugs.wine-staging.com/show_bug.cgi?id=682
RUN wget http://security.ubuntu.com/ubuntu/pool/main/f/freetype/libfreetype6_2.5.2-1ubuntu2_i386.deb && wget http://security.ubuntu.com/ubuntu/pool/main/f/freetype/libfreetype6_2.5.2-1ubuntu2_amd64.deb && dpkg -i libfreetype6_2.5.2-1ubuntu2_amd64.deb libfreetype6_2.5.2-1ubuntu2_i386.deb
# Work around https://bugs.wine-staging.com/show_bug.cgi?id=626
ENV WINPTY_SHOW_CONSOLE 1
RUN apt-get update -y && apt-get install -y strace
RUN id
RUN whoami
RUN strace ls
COPY cygwin32-env /etc/
COPY cygwin-shell /usr/bin/
COPY cygwin-rebase /usr/bin/
COPY cygwin32-init /usr/bin/
COPY cygwin32 /usr/bin/
RUN cygwin32-init
RUN cygwin32 -c cp -f /usr/bin/false /usr/bin/tput
RUN cygwin-rebase
