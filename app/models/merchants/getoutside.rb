module Merchants
  module Getoutside
    def self.extended(merchant)
      merchant.indexer = GetoutsideIndexer
      merchant.extend Parser
    end

    class GetoutsideIndexer < Indexer
      def compute_index_page
        # There are 2 pagers
        page_numbers = pager_node.css('li:not(.next):not(.previous)').map(&:content)
        page_numbers.map do |page_number|
          relative_path = "#{index_page.relative_path}?p=#{page_number}"
          IndexPage.new(index_page:    index_page,
                        merchant:      merchant,
                        relative_path: relative_path)
        end
      end
    end

    module Parser
      def attrs_from_node(node)
        product_name = node.at_css('a.product-image')['title'].squish.downcase
        product_desc = product_name.capitalize
        product_link = URI(node.at_css('.product-name a')['href'])
        # Pick last price node, which is normally the current price
        price_node    = node.css('span.price').last
        product_price = price_node.content[/(?<=CAD\$\s)?(([\d]{1,3}),?)+\.[\d]{2}/]

        sku_node    = price_node['id'].blank? ? price_node.parent : price_node
        product_sku = sku_node['id'].split(/-/).last

        { sku:         product_sku,
          name:        product_name,
          description: product_desc,
          link:        "//#{product_link.host}#{product_link.path}",
          price:       product_price }
      end
    end
  end
end
