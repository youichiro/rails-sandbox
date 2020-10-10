init:
	docker-compose run api bin/rails db:create
	docker-compose run api bin/rails db:migrate
	docker-compose run api bin/rails db:seed
	docker-compose stop

up-dev:
	docker-compose up --build
