ruby '2.2.1'
source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Devise for user authentication
gem 'devise'
# Use Pundit for user authorization
gem 'pundit'
# User figaro for credential storage
gem 'figaro'
# User active model serializers to serialize API output
gem 'active_model_serializers'
gem 'angular-rails-templates'

group :production do
	gem 'pg'
	gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'capybara'
  gem 'spring-commands-rspec'
  gem 'vcr'
  gem 'faker'
  gem 'shoulda'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Use sqlite3 as the database for Active Record
	gem 'sqlite3'
	gem 'pry-rails'
end

group :test do
	gem 'webmock'
end