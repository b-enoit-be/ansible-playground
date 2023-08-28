distributions = alpine ubuntu debian
COMPOSE_FILE = docker/compose.yml$(subst  $() ,,$(foreach distribution,$(distributions),$(if $($(distribution)),:docker/compose.$(distribution).yml)))

export

all: run

attach: docker/compose.yml
	@docker compose \
    	exec \
		$$node \
		bash

rebuild: .build all

inventory: cmd = ansible-inventory --graph
inventory: up

.build: docker/compose.yml
	@docker compose \
    	build

up: docker/compose.yml
	@docker compose \
		up \
		--attach controller \
		--abort-on-container-exit \
		--remove-orphans \
		--no-log-prefix

run: .run down

.run: cmd = ash
.run: docker/compose.yml
	-@docker compose \
		run \
		--rm \
		--remove-orphans \
		controller

down: nodes =
down: nodes_debian =
down: nodes_ubuntu =
down: docker/compose.yml
	@docker compose \
		down \
		$(down_flags) \
		--remove-orphans \
		--volumes

clean: down_flags = --rmi all
clean: down .clean

.clean: docker/compose.yml
	@git clean -df
