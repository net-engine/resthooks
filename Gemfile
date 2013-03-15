source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '4.0.0.beta1'

gem 'active_model_serializers'
gem 'httparty'
gem 'puma'
gem 'pg'
gem 'rails-observers'
gem 'sidekiq'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'foreman'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'pry'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rspec-rails'
  gem 'sinatra', require: false
  gem 'slim', require: false
end

group :test do
  gem 'database_cleaner', github: "bmabey/database_cleaner"
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
end
