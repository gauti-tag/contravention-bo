build:
		docker-compose build

run:
		docker-compose up -d

migrate: # Run pending migrations
		docker-compose run web bundle exec rails db:migrate
	
rollback: # Rollback DB
		docker-compose run web bundle exec rails db:rollback

logs:
		docker-compose logs -t --tail 2000 web

stop: # Stop containers
		docker-compose stop

status:
		docker-compose ps

connect:
		docker-compose exec web sh
