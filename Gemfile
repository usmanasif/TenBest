source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use bootstrap 3 sass port
gem 'bootstrap-sass', '~> 3.3.6'
# Also use Bootstrap's font-awesome-sass'
gem 'font-awesome-sass', '~> 4.7.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-turbolinks'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Paperclip gem for managing file uploads.  If you're not using rails 3 or 4, you'll need a different version.
gem 'paperclip'
gem 'fog'
# Simple breadcrumb for rails
gem "breadcrumbs_on_rails"

gem 'rest-client'
gem 'json'
gem 'social-share-button'
gem 'pg'
gem 'devise'
gem 'jquery-datatables-rails', '~> 3.4.0'
gem 'will_paginate'
gem 'jquery-ui-rails'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'friendly_id', '~> 5.1.0'
gem 'bootstrap-tagsinput-rails'

#Segment.io Analytics
gem 'analytics-ruby', :require => 'segment/analytics'
# staccato Google Analytics gem
gem 'staccato'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'sqlite3'
  gem 'dotenv-rails'
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rails-controller-testing', '0.1.1'
  gem 'minitest-reporters',       '1.1.9'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
