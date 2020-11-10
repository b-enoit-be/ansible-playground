FROM alpine:latest
LABEL maintainer="Benoît Geeraerts [https://b.enoit.be]"

WORKDIR /usr/local/ansible

COPY play.yml .
COPY inventory.yml /etc/ansible/hosts

RUN apk add --no-cache \
        ansible \
        py3-jmespath

ENTRYPOINT ["ansible-playbook"]
CMD ["play.yml"]
