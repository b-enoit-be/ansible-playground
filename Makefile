.EXPORT_ALL_VARIABLES:

all: attach

rebuild: .build all

inventory: cmd = ansible-inventory --graph
inventory: up

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
