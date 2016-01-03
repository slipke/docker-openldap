include env_make

.PHONY: run status build clean stop

ifdef production
FILE = -f docker-compose.yml -f production.yml
else
FILE = -f docker-compose.yml
endif

run: build
	docker-compose $(FILE) up -d

stop:
	docker-compose $(FILE) stop

status:
	docker-compose $(FILE) ps

build: .built

.built:
	docker-compose $(FILE) build
	touch .built

clean: stop
	docker-compose $(FILE) rm -f
	rm .built