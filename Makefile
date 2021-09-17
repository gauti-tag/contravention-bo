build:
		docker-compose build

dev:
		docker-compose -f docker-compose.yml -f docker-compose.test.yml up -d

run:
		docker-compose up -d

migrate: # Run pending migrations
		docker-compose exec web bundle exec rails db:migrate
	
rollback: # Rollback DB
		docker-compose exec web bundle exec rails db:rollback

logs:
		docker-compose logs -t --tail 2000 web

stop: # Stop containers
		docker-compose stop

status:
		docker-compose ps

connect:
		docker-compose exec web sh
