FROM python:alpine

LABEL org.opencontainers.image.authors="Benoît Geeraerts [https://b.enoit.be]"
LABEL ansible_type=controller

COPY etc /etc/ansible

RUN apk add --no-cache \
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

COPY root/.ash_history /root/.ash_history
COPY --chmod=755 bin /usr/local/bin

WORKDIR /usr/local/ansible
VOLUME /usr/local/share/.ssh

ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
CMD [ "ansible-playbook", "play.yml" ]
