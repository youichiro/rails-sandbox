init:
	docker-compose build
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
