##
# Store merchant information
#
class Getoutside < Merchant::Base
  self.base_url    = '//www.getoutsideshoes.com'
  self.index_pages = []

  # Move this into article
  self.item_css    = 'ul.products-grid li.item'
end