.PHONY: install
install:
	composer install --no-interaction

.PHONY: update
update:
	composer update --no-interaction

.PHONY: validate
validate:
	composer validate --strict

.PHONY: normalize
normalize:
	vendor/bin/composer-normalize

.PHONY: outdated
outdated:
	composer outdated --direct