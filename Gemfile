source 'https://rubygems.org'

gem 'rails', '4.1.5'

ruby '2.1.1'

gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'fog', '~> 1.22.0'
gem 'pry'

group :production do
  gem 'rails_12factor'
end

# spree extensions
gem 'spree', :git => 'https://github.com/spree/spree.git', :branch => '2-3-stable'
gem 'spree_gateway', :git => 'https://github.com/spree/spree_gateway.git', :branch => '2-3-stable'
gem 'spree_auth_devise', :git => 'https://github.com/spree/spree_auth_devise.git', :branch => '2-3-stable'
gem 'spree_mobile_endpoints', :git => 'https://github.com/ulices/spree_mobile_endpoints.git', :branch => '2-3-stable'
gem 'spree_mail_settings', :git => 'https://github.com/rodolfospalenza/spree_mail_settings.git'

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rspec-rails'
end
