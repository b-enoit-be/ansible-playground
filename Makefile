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

.build: compose.yml
	@docker compose \
		build

up: compose.yml
	@docker compose \
		up \
		--attach controller \
		--abort-on-container-exit \
		--remove-orphans \
		--no-log-prefix

run: .run down

.run: cmd = ash
.run: compose.yml
	-@docker compose \
		run \
		--rm \
		--remove-orphans \
		controller

down: compose.yml
	-@docker rm \
		--force \
		--volumes \
		$$( \
			docker ps \
				--all \
				--quiet \
				--filter "label=ansible_type" \
		) 2> /dev/null
	@docker compose \
		down \
		$(down_flags) \
		--remove-orphans \
		--volumes

clean: down_flags = --rmi all
clean: down .clean

.clean: compose.yml
	@git clean -df
