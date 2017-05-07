require 'buyma_insider'

include RethinkDB::Shortcuts

client = Elasticsearch::Client.new
conn   = r.connect(db: :"buyma_insider_#{BuymaInsider.environment}")
conn.repl

$es                         = $elasticsearch unless defined? $elasticsearch
search_template_tester      = Tempfile.create(['search_template_tester', '.yml'], './tmp')
search_template_tester_path = search_template_tester.path
search_q                    = -> () { YAML::load_file(search_template_tester_path) }
puts 'Tester file `%s`' % search_template_tester_path
search_template_tester.close

def get_article
  Article.new({ id:          "abc:#{Faker::Code.ean}",
                merchant_id: 'zar',
                sku:         Faker::Code.ean,
                name:        Faker::Commerce.product_name,
                price:       Faker::Commerce.price,
                description: Faker::Commerce.product_name,
                link:        '//test1.com', })
end

def get_user
  User.new({ username: Faker::Internet.user_name,
             email:    Faker::Internet.email,
             password: 123 })
end

