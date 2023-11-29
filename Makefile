COMPOSE_FILE = docker/compose.yml
node = controller
nodes_alpine ?= ${nodes}

export

all: run

attach: docker/compose.yml
	@docker compose \
		exec \
		$$node \
		sh

rebuild: build all

inventory: cmd = ansible-inventory --graph
inventory: up

build: docker/compose.yml
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
	@env | { grep '^nodes_' || true; } > docker/nodes.env
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
