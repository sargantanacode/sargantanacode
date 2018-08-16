source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'rails-i18n', '~> 5.1', '>= 5.1.1'
gem 'translate_enum'
gem 'friendly_id'
gem 'globalize', git: 'https://github.com/globalize/globalize'
gem 'globalize-accessors'
gem 'dotenv-rails'
gem 'mysql2'
gem 'devise'
gem 'puma', '~> 3.11'
gem 'webpacker'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'carrierwave'
gem 'redcarpet'
gem 'rouge'
gem 'kaminari'
gem 'mail_form'
gem 'closure_tree'
gem 'akismet'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'guard-rspec'
end

group :test do
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'faker'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
