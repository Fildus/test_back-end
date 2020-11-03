user := $(shell id -u)
group := $(shell id -g)
dc := USER_ID=$(user) GROUP_ID=$(group) docker-compose
dr := $(dc) run --rm
de := docker-compose exec
sy := $(de) php bin/console
drtest := $(dc) -f docker-compose.test.yml

.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: dev
dev: ## Starts the development server
	$(dc) up -d
	$(dr) --no-deps node yarn dev-server
	$(dc) stop

.PHONY: install
install: vendor node_modules public/build ## Install the project dependencies
	$(dc) build
	$(dc) -f docker-compose.test.yml build

.PHONY: vendor
vendor:
	$(dr) --no-deps php composer install

.PHONY: node_modules
node_modules:
	$(dr) --no-deps node yarn

.PHONY: public/build
public/build:
	$(dr) --no-deps node yarn run build

.PHONY: install
clean: ## Clean
	- $(dc) stop
	- $(dc) down --volumes --remove-orphans
	- sudo rm -R vendor/ var/ node_modules

.PHONY: tt
tt: ## Launch the phpunit watcher
	$(drtest) run php-test vendor/bin/phpunit-watcher watch --filter="nothing"
	$(dc) -f docker-compose.test.yml down

.PHONY: lint
lint: ## Analyze the code
	docker run -v $(PWD):/app --rm phpstan/phpstan:0.12.27 analyse

.PHONY: fix
fix: ## Launch php-cs-fixer
	$(dc) run --rm php vendor/bin/php-cs-fixer fix --allow-risky=yes
