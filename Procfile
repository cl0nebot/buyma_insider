web: bundle exec ruby ./app.rb
sidekiq: bundle exec sidekiq --environment $ENVIRONMENT --config ./config/sidekiq.yml --require ./sidekiq.rb
sidekiq_web: rackup --quiet
