source :rubygems

gem 'rails', '3.2.11'

gem 'json'
gem 'mysql2'
gem 'rspec-rails'
gem 'prefetch-rspec'
gem 'jquery-rails'
gem 'kaminari'
gem 'unicorn'

gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-github'

gem 'gravtastic'
gem "friendly_id", "~> 4.0.0.beta14"

gem 'resque', :require => 'resque/server'
gem 'redis'


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'hirb-unicode'
  gem 'unicorn'
  gem 'capistrano'
  gem 'capistrano-resque'
end

group :production do
  gem 'exception_notification', github: 'smartinez87/exception_notification'
end
