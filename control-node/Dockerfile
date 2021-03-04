FROM alpine:edge
LABEL maintainer="Benoît Geeraerts [https://b.enoit.be]"

WORKDIR /usr/local/ansible

COPY play.yml .
COPY inventory.yml /etc/ansible/hosts
COPY ansible.cfg /etc/ansible/ansible.cfg

RUN apk add --no-cache \
        ansible \
        py3-jmespath \
    && echo "ansible-playbook play.yml -i inventory.yml" > /root/.ash_history
        
ENTRYPOINT ["ansible-playbook"]
CMD ["play.yml", "-i", "inventory.yml"]
