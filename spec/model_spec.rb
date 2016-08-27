require 'faker'
require 'minitest/autorun'
require 'active_support'
require 'active_support/core_ext/numeric/time'

require 'buyma_insider'
require 'nobrainer_config'

class ArticleModelBaseTest < Minitest::Test
  def test_create_base_article
    1000.times {
      a  = Article.create sku:         Faker::Code.ean,
                          name:        Faker::Commerce.product_name,
                          description: Faker::Hipster.sentences,
                          link:        Faker::Internet.url
      ph = PriceHistory.new article_id: a.id
      (1..90).map { |d| d.days.from_now.utc.to_i.to_s }.each do |time|
        ph.prices[time] = Faker::Commerce.price
      end

      ph.save
    }
  end

  def time_now
    Time.now.utc.to_i.to_s
  end
end