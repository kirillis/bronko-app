source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '4.0.4'
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', '~> 3.1.0'
gem 'jquery-ui-rails', '~> 5.0.0'
gem 'turbolinks', '~> 2.2.1'
gem 'jbuilder', '~> 1.2'
gem 'haml'
gem 'haml-rails'
gem 'thin'
gem 'autoprefixer-rails', '~> 3.0.1'
gem 'ancestry', '~> 2.1.0'
gem 'faker', '~> 1.3.0'
gem 'bourbon', '~> 2.1.0'
gem 'neat', '~> 1.5.0'
gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password

group :doc do
  gem 'sdoc', require: false # bundle exec rake doc:rails generates the API under doc/api.
end

group :production do
  gem 'puma'
  gem 'pg', '0.15.1' # use postgresql on production
  gem 'rails_12factor', '0.0.2'
end

group :development do
  gem 'sqlite3' # Use sqlite3 as the database for Active Record
  # gem 'debugger'
  gem 'awesome_print', :require => 'ap'
  # ---------------------------------
  # better errors, binding of caller and meta request from video tutorial: 
  # http://railscasts.com/episodes/402-better-errors-railspanel?autoplay=true
  gem 'better_errors', '< 2.0.0'
  gem 'binding_of_caller'
  gem 'meta_request'
  # ---------------------------------
end