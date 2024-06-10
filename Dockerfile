FROM owhkgvcvbahevhhqftnedviazgxpvcovcesrqhcvwpzjzherwthhpjmyulworhypgw

RUN pacman-key --init && pacman-key --populate archlinux
RUN pacman -S --noconfirm chrony
COPY chrony.conf /etc/chrony/chrony.conf
RUN rm -rf /etc/pacman.d/gnupg
USER nobody

EXPOSE 123/udp

CMD ["/seccomp-strict", "chronyd", "-d", "-x", "-f", "/etc/chrony/chrony.conf", "-U", "-F", "1"]
