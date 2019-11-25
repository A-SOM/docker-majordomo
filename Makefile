THIS_FILE := $(lastword $(MAKEFILE_LIST))
#envs
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

#guid/uid
export UID = $(shell id -u)
export GID = $(shell id -g)

#vars
APP_PATH=./app
DB_DUMP_FILE=./app/db_terminal.sql
.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

init: build up
install: build up

clone_code: ## git clone code
	@ mkdir -p ./app
	@ mkdir -p ./db-data
	@ git clone https://github.com/sergejey/majordomo.git ./app
pull: ## git pull cod
	@ cd ./app | git pull
build: ## Build docker containers
	@$(call docker_compose, build)
up: ## Up docker containers
	@$(call docker_compose, up -d)

stop: ## Stop docker containers
	@$(call docker_compose, stop)

restart: ## Restart docker containers
	@$(call docker_compose, restart)

ps: ## Ps docker containers
	@$(call docker_compose, ps)

exec-mysql: ## Enter to mysql container
	@$(call docker_compose, exec mysql bash)

exec-app: ## Enter to app container
	@$(call docker_compose, exec majordomo bash)

app-owner-user: ## Set file owner to current user for app
	@ docker-compose exec -T majordomo chown www-data:www-data -R /var/www/html && chmod -R 777 /var/www/html
init-db:
	@ sleep 10s
	@$(call docker_compose, exec mysql mysqladmin -p$(MYSQL_ROOT_PASSWORD) drop $(MYSQL_DATABASE))
	@$(call docker_compose, exec mysql mysqladmin -p$(MYSQL_ROOT_PASSWORD) create $(MYSQL_DATABASE))
	@ cat ./app/db_terminal.sql | docker-compose exec -T mysql mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE)

%:
    @:
define docker_compose
    @docker-compose -f ./docker-compose.yml $(1)
endef
