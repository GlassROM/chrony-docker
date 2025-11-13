FROM ghcr.io/glassrom/os-image-updater:master

RUN mv /etc/ld.so.preload /etc/ld.so.preload.bak

RUN pacman-key --init && pacman-key --populate archlinux
RUN pacman -S --noconfirm chrony
COPY chrony.conf /etc/chrony/chrony.conf
RUN rm -rf /etc/pacman.d/gnupg
RUN mv /etc/ld.so.preload.bak /etc/ld.so.preload
USER nobody

EXPOSE 123/udp

CMD ["/seccomp-strict", "chronyd", "-d", "-x", "-f", "/etc/chrony/chrony.conf", "-U", "-F", "1"]
