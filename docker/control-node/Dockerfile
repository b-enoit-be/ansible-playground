FROM python:alpine

LABEL org.opencontainers.image.authors="Benoît Geeraerts [https://b.enoit.be]"
LABEL ansible_type=controller

WORKDIR /usr/local/ansible
COPY requirements.txt /opt/ansible/requirements.txt

RUN apk add --no-cache \
        openssh-client \
    && apk add --no-cache --virtual _build-dependencies \
        libffi-dev \
        gcc \
        musl-dev \
    && pip install --no-cache-dir --requirement /opt/ansible/requirements.txt \
    && apk del _build-dependencies

COPY .ash_history /root/.ash_history

ENTRYPOINT ["ansible-playbook"]
CMD ["play.yml"]
