COMPOSE_FILE = docker/compose.yml

export

all: run

attach: compose.yml
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
