COMPOSE_FILE = docker/compose.yml
node = controller

nodes = 0
nodes_ubuntu = 0
nodes_debian = 0
nodes_alpine = 0
ifdef nodes
	nodes_alpine = $(nodes)
endif

export

all: run

attach: docker/compose.yml
	-@docker compose \
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

run: .run attach down

.run: cmd = ash
.run: docker/compose.yml
	@env | { grep '^nodes_' || true; } > docker/nodes.env
	@docker compose up --detach
# FIXME: see if there is a better way here, as the watching process will outlive make
	-@docker compose watch \
		--no-up \
		--quiet \
		&> docker/logs/compose-watch.log &

down: docker/compose.yml
	@docker compose \
		down \
		$(down_flags) \
		--timeout 0 \
		--remove-orphans \
		--volumes

clean: down_flags = --rmi all
clean: down .clean

.clean: docker/compose.yml
	@git clean -df

ps: docker/compose.yml
	@docker compose ps --all

logs: docker/compose.yml
	@docker compose logs --follow