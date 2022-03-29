FROM python:alpine
LABEL maintainer="Benoît Geeraerts [https://b.enoit.be]"
LABEL ansible=controller

WORKDIR /usr/local/ansible

COPY play.yml .

RUN apk add --no-cache \
        openssh-client \
    && apk add --no-cache --virtual _build-dependencies \
        build-base \
        libffi-dev \
        openssl-dev \
        python3-dev \
    && pip install \
        ansible \
        ansible-lint \
        docker \
        docker-compose \
        jmespath \
        lxml \
        netaddr \
    && apk del _build-dependencies \
    && echo "ansible-inventory --graph" > /root/.ash_history \
    && echo "ansible-playbook managed-node/create.yml" >> /root/.ash_history \
    && echo "ansible-playbook play.yml" >> /root/.ash_history
        
ENTRYPOINT ["ansible-playbook"]
CMD ["play.yml"]
