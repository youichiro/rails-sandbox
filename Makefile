init:
	docker-compose run --rm api bin/rails db:create
	docker-compose run --rm api bin/rails db:migrate
	docker-compose run --rm api bin/rails db:seed
	docker-compose stop

up-dev:
	docker-compose up --build -d
	docker-compose logs -f
