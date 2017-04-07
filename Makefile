heroku-recreate-db:
	heroku pg:reset DATABASE --confirm tranquil-plains-56319
	heroku run rake db:migrate
	heroku run rake bookstore:import_countries
	heroku run rake bookstore:import_books
	heroku run rails db:seed
