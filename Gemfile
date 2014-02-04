source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=nanomedtrix

gem 'rails', '~> 4.0.2'

group :development, :test do
  gem 'sqlite3',     '~> 1.3.8'
  gem 'rspec-rails', '~> 2.13.1'
end

group :test do
  gem 'selenium-webdriver', '~> 2.35.1'
  gem 'capybara',           '~> 2.1.0'
end

gem 'sass-rails',     '~> 4.0.1'
gem 'bootstrap-sass', '~> 3.1.0.1'
gem 'uglifier',       '~> 2.1.1'
gem 'coffee-rails',   '~> 4.0.1'
gem 'jquery-rails',   '~> 3.1.0'
gem 'turbolinks',     '~> 1.1.1'
gem 'jbuilder',       '~> 1.0.2'

group :doc do
  gem 'sdoc', '~> 0.3.20', require: false
end

group :production do
  gem 'pg',             '~> 0.15.1'
  gem 'rails_12factor', '~> 0.0.2'
end

gem 'spree',                git: 'https://github.com/spree/spree.git',                branch: '2-1-stable'

gem 'spree_gateway',        git: 'https://github.com/spree/spree_gateway.git',        branch: '2-1-stable'
gem 'spree_auth_devise',    git: 'https://github.com/spree/spree_auth_devise.git',    branch: '2-1-stable'
gem 'spree_static_content', git: 'https://github.com/spree/spree_static_content.git', branch: '2-1-stable'

gem 'tinymce-rails',       '~> 3.5.8.3'
gem 'acts-as-taggable-on', '~> 3.0.1'
