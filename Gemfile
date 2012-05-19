source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'rake', '0.9.2'
gem 'jquery-rails'
gem 'haml', '~> 3.0'
gem 'bilge-pump', git: 'git://github.com/flipstone/bilge-pump.git', branch: '3390d04'
gem 'haml-sprockets'

group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg'
end

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 1.4.0'
  gem 'jasmine', '1.2.0.rc3',
    git: "git://github.com/pivotal/jasmine-gem.git",
    branch: "c72e8d248d49a1ebe53f31a09ac511194ad4edf1"

  gem 'rack-asset-compiler'
  gem 'guard-shell'
end
