source 'https://rubygems.org'

gem 'bundler',                  require: 'bundler/setup'
gem 'require_all'
gem 'dotenv'
gem 'rack'
gem 'activesupport',            require: ['active_support',
                                          'active_support/core_ext/module/delegation']
gem 'actionpack',               require: ['action_controller/metal/strong_parameters']

gem 'sinatra',                  github: 'sinatra/sinatra', branch: 'master'
gem 'sinatra-contrib',          require: ['sinatra/json', 'sinatra/cookies']
gem 'sinatra-param',            github: 'snwfog/sinatra-param', branch: 'master', require: 'sinatra/param'
gem 'sinatra-cross_origin',     require: 'sinatra/cross_origin'

gem 'active_model_serializers', '~> 0.10.0'
gem 'nokogiri'
gem 'rest-client'
gem 'hashie'

# Security / Login
gem 'bcrypt',                   github: 'codahale/bcrypt-ruby', require: 'bcrypt'
gem 'net_http_ssl_fix'          # require: false if Gem.win_platform?

# Persistence
gem 'rethinkdb'
gem 'nobrainer'
gem 'redis'
gem 'redis-activesupport'
gem 'connection_pool'

# Bus / Messaging
gem 'message_bus'

# Caching
gem 'lru_redux'

# Searching
gem 'elasticsearch'
gem 'elasticsearch-dsl'

# Email
gem 'mail'

# Job
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sidekiq-unique-jobs' # Experimental

# Tasks
gem 'rake'
gem 'colorize',                require: false

# Integration
gem 'sentry-raven',            require: 'sentry-raven-without-integrations'
gem 'slackiq'
# gem 'slack-notifier'
gem 'money-open-exchange-rates' # Money + exchange rates

# Logging
gem 'httplog'
gem 'logging'

# Deployment
gem 'foreman'
gem 'unicorn' if RUBY_PLATFORM =~ /darwin/

# Misc
gem 'faker'
gem 'pry',                     require: false # for debugging

group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano-template'
  gem 'shotgun',               require: false
  gem 'rubocop',               require: false
  gem 'hirb',                  require: false
  gem 'coolline',              require: false
  gem 'awesome_print'
  gem 'table_print',           require: false
  gem 'pry-byebug',            require: false
end

group :test do
  gem 'minitest'
  gem 'rspec'
  gem 'nyan-cat-formatter'
# gem 'redis-stat'
end

# Not used for now
# case RUBY_PLATFORM
# when /darwin/
#   gem 'guard'
#   gem 'guard-minitest'
# end
