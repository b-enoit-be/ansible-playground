ARG DISTRO=alpine
FROM ${DISTRO}

ARG DISTRO=${DISTRO:-alpine}
ARG PACKAGE_MANAGER_UPDATE_CMD="true"
ARG PACKAGE_MANAGER_INSTALL_CMD="apk add --no-cache"

LABEL org.opencontainers.image.authors="Benoît Geeraerts [https://b.enoit.be]"
LABEL com.ansible.node=managed
LABEL com.ansible.inventory.group=nodes
LABEL com.ansible.os.family=${DISTRO}

RUN ${PACKAGE_MANAGER_UPDATE_CMD} \
    && ${PACKAGE_MANAGER_INSTALL_CMD} \
        openssh-server \
        python3 \
        sudo \
    && ssh-keygen -A \
    && echo "root:$(tr -cd '[:print:]' < /dev/urandom | fold -w30 | head -n1 | base64)" \
        | chpasswd \
    && install --directory /root/.ssh --group root --owner root --mode 700 \
    && install --directory /run/sshd \
    && ln -sf /usr/local/share/.ssh/id_ed25519.pub /root/.ssh/authorized_keys

EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D", "-e" ]