FROM alpine

LABEL org.opencontainers.image.authors="Benoît Geeraerts [https://b.enoit.be]"
LABEL ansible_type=node

RUN apk add --no-cache \
        openssh \
    && ssh-keygen -A \
    && echo "root:$(tr -cd '[:print:]' < /dev/urandom | fold -w30 | head -n1 | base64)" \
        | chpasswd \
    && install --directory /root/.ssh --group root --owner root --mode 700 \
    && ln -sf /usr/local/share/.ssh/id_ed25519.pub /root/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]