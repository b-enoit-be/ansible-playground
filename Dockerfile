FROM alpine:latest
LABEL maintainer="Benoît Geeraerts [https://b.enoit.be]"

WORKDIR /ansible

COPY play.yml .
COPY inventory.yml /etc/ansible/hosts

RUN apk add --no-cache ansible 

ENTRYPOINT ["ansible-playbook"]
CMD ["play.yml"]
