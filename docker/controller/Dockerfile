FROM python:alpine

LABEL org.opencontainers.image.authors="Benoît Geeraerts [https://b.enoit.be]"
LABEL ansible_type=controller

WORKDIR /usr/local/ansible
COPY opt/ansible/requirements.txt /opt/ansible/requirements.txt
COPY --chmod=755 usr/local/bin/entrypoint /usr/local/bin/entrypoint

RUN apk add --no-cache \
        git \
        openssh-client \
        tree \
    && apk add --no-cache --virtual _build-dependencies \
        libffi-dev \
        gcc \
        musl-dev \
    && python -m pip install --no-cache-dir --requirement /opt/ansible/requirements.txt \
    && apk del _build-dependencies \
    && ssh-keygen -o -a 100 \
        -t ed25519 \
        -f ~/.ssh/id_ed25519 \
        -C 'john.doe@example.org' \
        -P ''

COPY root/.ash_history /root/.ash_history

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["ansible-playbook", "play.yml"]
