FROM python:alpine

LABEL org.opencontainers.image.authors="Benoît Geeraerts [https://b.enoit.be]"
LABEL com.ansible.node=controller


RUN --mount=type=bind,source=docker/etc/requirements.txt,target=/etc/ansible/requirements.txt \
    apk add --no-cache \
        docker-cli \
        docker-cli-compose  \
        openssh-client \
        tree \
    && apk add --no-cache --virtual _build-dependencies \
        libffi-dev \
        gcc \
        musl-dev \
    && python -m pip install --no-cache-dir --requirement /etc/ansible/requirements.txt \
    && apk del _build-dependencies \
    && ssh-keygen -o -a 100 \
        -t ed25519 \
        -f ~/.ssh/id_ed25519 \
        -C 'john.doe@example.org' \
        -P ''

COPY docker/root/.ash_history /root/.ash_history
COPY --chmod=755 docker/bin /usr/local/bin

COPY play.yml /usr/local/ansible/play.yml
COPY ansible.cfg /usr/local/ansible/ansible.cfg

COPY inventories /usr/local/ansible/inventories
COPY library /usr/local/ansible/library
COPY roles /usr/local/ansible/roles

WORKDIR /usr/local/ansible
VOLUME /usr/local/share/.ssh

ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
CMD [ "ansible-playbook", "play.yml" ]
