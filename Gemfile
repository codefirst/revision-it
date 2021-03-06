source 'https://rubygems.org'

# ------------------------------------------------------------------------------------------
# rails core
# ------------------------------------------------------------------------------------------
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# ------------------------------------------------------------------------------------------
# authentication
# ------------------------------------------------------------------------------------------
gem 'devise'
gem 'omniauth'
gem 'omniauth-oauth2', '~> 1.1.2'
gem 'omniauth-github', '~> 1.1.1'
gem 'settingslogic'
# ------------------------------------------------------------------------------------------
# Github
# ------------------------------------------------------------------------------------------
# github hook
gem "github_api"

# ------------------------------------------------------------------------------------------
# View
# ------------------------------------------------------------------------------------------
# Use bootstrap
gem 'less-rails'
gem 'twitter-bootstrap-rails'

# Use HAML for html
gem 'haml-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use sass as Stylesheet
gem 'sass-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# ------------------------------------------------------------------------------------------
# group specified
# ------------------------------------------------------------------------------------------
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem "codeclimate-test-reporter", require: nil
  gem 'coveralls', require: false
end

group :production do
  gem 'pg', '0.17.0'
  gem 'thin'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
