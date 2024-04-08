FROM python:alpine

LABEL org.opencontainers.image.authors="Benoît Geeraerts [https://b.enoit.be]"
LABEL com.ansible.node=controller

RUN apk add --no-cache \
        docker-cli \
        docker-cli-compose  \
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
    && pipx install --include-deps ansible \
    && pipx inject ansible \
        ansible-lint \
        docker \
        jmespath \
        lxml \
        netaddr

COPY docker/etc/.history /home/nobody/.history
COPY docker/etc/ssh.conf /etc/ssh/ssh_config.d/ssh.conf
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
