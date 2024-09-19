FROM python:alpine

LABEL org.opencontainers.image.authors="Benoît Geeraerts [https://b.enoit.be]"
LABEL com.ansible.inventory.group=controller

RUN apk add --no-cache \
        docker-cli \
        docker-cli-compose  \
        git \
        openssh-client \
        tree \
    && mkdir -p /usr/local/share/.ssh \
    && install -d -m 0755 -o nobody -g nobody \
        /home/nobody \
        /home/nobody/.ssh \
    && ssh-keygen -o -a 100 \
        -t ed25519 \
        -f /home/nobody/.ssh/id_ed25519 \
        -C 'john.doe@example.org' \
        -P '' \
    && cp /home/nobody/.ssh/id_ed25519.pub /usr/local/share/.ssh \
    && chmod u=rw,g=,o= /usr/local/share/.ssh/id_ed25519.pub \
    && chown -R nobody:nobody /home/nobody/.ssh

USER nobody

ENV HOME /home/nobody
ENV HISTFILE /home/nobody/.history
ENV PATH /home/nobody/.local/bin:$PATH

RUN python -m pip install --no-cache-dir --user pipx \
    && pipx install --include-deps \
        ansible \
        ansible-lint \
    && pipx inject ansible \
        docker \
        jmespath \
        lxml \
        netaddr

COPY etc/.history /home/nobody/.history
COPY etc/ssh.conf /etc/ssh/ssh_config.d/ssh.conf

WORKDIR /usr/local/ansible
VOLUME /usr/local/share/.ssh

CMD [ "ansible-playbook", "play.yml" ]
