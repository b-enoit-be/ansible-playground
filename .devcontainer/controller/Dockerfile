FROM python:alpine

LABEL org.opencontainers.image.authors="Benoît Geeraerts [https://b.enoit.be]"
LABEL com.ansible.inventory.group=controller

RUN apk add --no-cache \
        docker-cli \
        docker-cli-compose  \
        git \
        gnupg \
        openssh-client \
        pipx \
        tree \
    && mkdir -p /usr/local/share/.ssh \
    && ssh-keygen -o -a 100 \
        -t ed25519 \
        -f $HOME/.ssh/id_ed25519 \
        -C 'john.doe@example.org' \
        -P ''

RUN --mount=type=bind,src=etc/ansible.requirements.txt,target=ansible.requirements.txt \
    pipx install --include-deps \
        ansible \
        ansible-lint \
    && pipx inject ansible \
        --requirement ansible.requirements.txt

ENV HISTFILE /root/.history
ENV PATH /root/.local/bin:$PATH

COPY etc/.history /root/.history
COPY etc/ssh.conf /etc/ssh/ssh_config.d/ssh.conf

WORKDIR /usr/local/ansible
VOLUME /usr/local/share/.ssh

COPY --chmod=755 bin/entrypoint /usr/local/bin/entrypoint
ENTRYPOINT [ "entrypoint" ]

CMD [ "ansible-playbook", "play.yml" ]
