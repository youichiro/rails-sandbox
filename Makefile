init:
	docker pull ruby:2.7.2-slim-buster
	docker-compose build
	docker-compose run --rm api bin/rails db:create
	docker-compose run --rm api bin/rails db:migrate
	docker-compose run --rm api bin/rails db:seed

bundle-install:
	docker-compose run --rm api bundle install
	bundle install

migrate:
	docker-compose run --rm api bin/rails db:migrate

console:
	docker-compose run --rm api bin/rails c

rspec:
	docker-compose run --rm api bundle exec rspec
