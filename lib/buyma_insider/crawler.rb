require 'logging'
require 'buyma_insider/url_cache'
require 'buyma_insider/http'

class Crawler
  attr_accessor :merchant

  def initialize(merchant)
    @logger = Logging.logger[merchant]
    @merchant  = merchant

    @url_cache = UrlCache.new(merchant)
  end

  def crawl(&blk)
    merchant.index_pages.each do |indexer|
      history = CrawlHistory.create(description: "#{@merchant.to_s} '#{indexer.to_s}'")
      begin
        @logger.info "#{history.description} started at #{Time.now.utc}"
        indexer.each_page do |page_url|
          @logger.info("Requesting page '#{page_url}'")

          # Add url to cache, break if already exists
          next unless @url_cache.add? page_url

          # Get link HTML and set @response if not in url cache
          response = Http.get page_url

          # Parse into document from response
          next if response.body.empty?

          @document = Nokogiri::HTML(response.body)
          @document.css(merchant.item_css).each do |it|
            attrs = @merchant.article_model.attrs_from_node(it)

            # IMPT: Just yield the new article
            blk.call(Article.new(attrs))
            history.items_count  += 1
          end

          history.traffic_size += response.content_length
        end
        history.status = :success
      rescue Exception => ex
        history.status = :failed
        @logger.error "#{history.description} encountered error", ex
      ensure
        history.save
        @logger.info <<-HISTORY
          #{history.description} crawl finished with #{history.status} in #{history.elapsed_time}s
          [Total items: #{history.items_count}, Traffic size: #{history.traffic_size}B]
        HISTORY
      end
    end
  end
end