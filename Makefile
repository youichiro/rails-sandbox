init:
	docker pull ruby:2.7.2-slim-buster
	docker-compose build --no-cache
	docker-compose run --rm api bin/rails db:create
	docker-compose run --rm api bin/rails db:migrate
	docker-compose run --rm api bin/rails db:seed

up-dev:
	docker-compose up -d
	docker-compose logs -f

bundle-install:
	docker-compose run --rm api bundle install

migrate:
	docker-compose run --rm api bin/rails db:migrate

console:
	docker-compose run --rm api bin/rails c
