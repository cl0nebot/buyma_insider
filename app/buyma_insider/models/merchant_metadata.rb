require 'nokogiri'
require 'nobrainer'

require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/class/attribute'
require 'active_support/descendants_tracker'

class MerchantMetadata
  include NoBrainer::Document
  
  # has_many :crawl_history

  field :id,           primary_key: true, required: true, format: /[a-z]{3}/
  field :name,         type: String, required: true
  field :base_url,     type: String, required: true
  field :pager_css,    type: String
  field :item_css,     type: String, required: true
  field :index_pages,  type: Set, required: true
  field :ssl,          type: Boolean

  alias_method :code, :id
  alias_method :code=, :id=

  def name_capitalized
    name.capitalize
  end
end