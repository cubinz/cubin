FROM ubuntu:20.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y locales gnupg --no-install-recommends && \
        dpkg-reconfigure locales && \
        echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen && \
        /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 \
        LANGUAGE=en_US.UTF-8 \
        LC_ALL=en_US.UTF-8

RUN apt-get update && \
        apt install dbus-x11 -y  && \
        apt install sudo -y  && \ 
        apt install bash -y  && \ 
        apt install firefox -y  && \ 
        apt install net-tools -y  && \
        apt install novnc -y  && \ 
        apt install x11vnc -y  && \ 
        apt install xvfb -y  && \
        apt install supervisor -y  && \ 
        apt install xfce4 -y  && \
        apt install gnome-shell -y  && \
        apt install ubuntu-gnome-desktop -y  && \
        apt install gnome-session -y  && \ 
        apt install gdm3 -y  && \ 
        apt install tasksel -y  && \
        apt install ssh  -y  && \
        apt install terminator -y  && \
        apt install git -y  && \
        apt install nano -y  && \
        apt install curl -y  && \
        apt install wget -y  && \ 
        apt install zip -y  && \
        apt install unzip -y  && \
        apt-get autoclean -y  && \
        apt-get xterm -y  && \
        apt-get autoremove

RUN dpkg --add-architecture i386 && apt-get update
RUN apt-get install -y --no-install-recommends \
        wine32 \
        winetricks

RUN apt-get install -y --no-install-recommends \
        libgl1-mesa-glx:i386

RUN rm -rf /var/lib/apt/lists/*

ENV WINEARCH=win32

RUN curl https://dl.winehq.org/wine/wine-mono/7.0.0/wine-mono-7.0.0-x86.msi -o /root/wine-mono
RUN curl https://dl.winehq.org/wine/wine-gecko/2.47.2/wine-gecko-2.47.2-x86.msi -o /root/wine-gecko
RUN wine msiexec /i /root/wine-mono
RUN wine msiexec /i /root/wine-gecko

RUN mkdir /application
COPY utils /root/utils

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0.0

ENV DISPLAY_WIDTH=1920 \
    DISPLAY_HEIGHT=1080

ENV WORKDIR=/application \
    APPLICATION=notepad.exe

ENV COMMAND=""

CMD ["/root/utils/entrypoint.sh"]

EXPOSE 8080
