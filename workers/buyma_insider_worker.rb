$:.unshift(File.expand_path("lib"), File.dirname(__FILE__))

require 'sidekiq'
require 'buyma_insider'

class BuymaInsiderWorker
  include Sidekiq::Worker

  # def perform
  #   Ssense.new.crawl
  # end
end
