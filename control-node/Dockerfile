FROM python:alpine
LABEL maintainer="Benoît Geeraerts [https://b.enoit.be]"

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
        docker \
        docker-compose \
        jmespath \
    && apk del _build-dependencies \
    && echo "ansible-playbook play.yml" > /root/.ash_history
        
ENTRYPOINT ["ansible-playbook"]
CMD ["play.yml"]
