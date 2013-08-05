source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'less-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
gem 'twitter'
gem "twitter-bootstrap-rails"
group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails"
  gem "pry-rails"
  gem 'pry-debugger'
  gem "spork"
  gem "rb-fsevent"
  gem "guard-spork"
  gem "growl"
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'capybara'
end

group :test do
  gem "webmock"
end
gem 'nokogiri'

group :production do
  gem 'pg'
end
