nodes?=0

cmd:='ansible-playbook play.yml'

all: .up

rebuild: .build .up

inventory: cmd='ansible-inventory --graph'
inventory: .up

.build: docker/docker-compose.yml
	@docker compose \
		--file $< \
    	build

.up: docker/docker-compose.yml
	@cmd=${cmd} docker compose \
		--file $< \
		up \
		--attach controller \
		--abort-on-container-exit \
		--no-log-prefix

attach: docker/docker-compose.yml
	@cmd='tail -f /dev/null' docker compose \
		--file $< \
		up \
		--detach
	@docker compose \
		--file $< \
		exec \
		controller \
		ash

clean: docker/docker-compose.yml
	@docker compose \
   		--file $< \
		down \
		--rmi all \
		--volumes