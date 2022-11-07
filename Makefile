nodes?=0

cmd:='ansible-playbook play.yml'

all: .up

rebuild: .build .up
inventory: cmd='ansible-inventory --graph'
inventory: .up

.build:
	@docker compose \
		--file docker/docker-compose.yml \
    	build

.up:
	@cmd=${cmd} docker compose \
		--file docker/docker-compose.yml \
		up \
		--attach controller \
		--abort-on-container-exit \
		--no-log-prefix

attach:
	@cmd='tail -f /dev/null' docker compose \
		--file docker/docker-compose.yml \
		up \
		--detach
	@docker compose \
		--file docker/docker-compose.yml \
		exec \
		controller \
		ash

clean:
	@docker compose \
   		--file docker/docker-compose.yml \
			down \
			--rmi all \
			--volumes \