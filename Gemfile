source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.5', '>= 5.2.5.1'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 4.3'

# execjs
# gem 'libv8', '~> 3.11.8'
# gem 'execjs'
# gem 'therubyracer'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'sassc', '< 2.2.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# jQuery
gem 'jquery-rails'

# Bootstrap
gem 'bootstrap', '~> 4.3.1'

# Confirm Modal
gem 'data-confirm-modal'

# Devise
gem 'devise'

# SNS Auth
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

# rolify
gem 'rolify'

# Pundit
gem 'pundit'

# Active Admin
gem 'activeadmin'

# QRcode
gem 'rqrcode'
gem 'rqrcode_png'
gem 'chunky_png'

# Pager
gem 'kaminari'

# Enum Help
gem 'enum_help'

# dotenv
gem 'dotenv-rails'

# Seed
gem 'seed-fu'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # RSpec
  gem 'rspec-rails', '~> 3.6'

  #  Hirb
  gem 'hirb'
  gem 'hirb-unicode'

  # Pry
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'

  # Web Mailer
  gem 'letter_opener_web'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Better Errors
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'

  # Web Drivers
  gem 'webdrivers', '~> 3.0'
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'
