.EXPORT_ALL_VARIABLES:

all: attach

rebuild: .build all

inventory: cmd = ansible-inventory --graph
inventory: up

nodes: nodes = $(shell bash -c 'read -rp "How many Alpine nodes do you want? " nodes; echo $$nodes')
nodes: nodes_debian = $(shell bash -c 'read -rp "How many Debian nodes do you want? " nodes; echo $$nodes')
nodes: nodes_ubuntu = $(shell bash -c 'read -rp "How many Ubuntu nodes do you want? " nodes; echo $$nodes')
nodes: attach

.build: docker/docker-compose.yml
	@docker compose \
		--file $< \
    	build

up: docker/docker-compose.yml
	@docker compose \
		--file $< \
		up \
		--attach controller \
		--abort-on-container-exit \
		--no-log-prefix

attach: .attach down

.attach: cmd = ash
.attach: docker/docker-compose.yml
	-@docker compose \
		--file $< \
		run \
		--rm \
		controller

down: nodes =
down: nodes_debian =
down: nodes_ubuntu =
down: docker/docker-compose.yml
	@docker compose \
   		--file $< \
		down \
		$(down_flags) \
		--volumes

clean: down_flags = --rmi all
clean: down .clean

.clean: docker/docker-compose.yml
	@git clean -df
