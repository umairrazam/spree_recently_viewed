module Spree::BaseHelperDecorator
  def cached_recently_viewed_products_ids
    (cookies['recently_viewed_products'] || '').split(', ')
  end

  def cached_recently_viewed_products
    Spree::Product.new.find_by_array_of_ids(cached_recently_viewed_products_ids)
  end
end

Spree::BaseHelper.include Spree::BaseHelperDecorator
