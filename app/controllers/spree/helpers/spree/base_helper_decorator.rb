module Spree::BaseHelperDecorator
  def self.prepended(base)
    def base.cached_recently_viewed_products_ids
      (cookies['recently_viewed_products'] || '').split(', ')
    end

    def base.cached_recently_viewed_products
      Spree::Product.new.find_by_array_of_ids(cached_recently_viewed_products_ids)
    end
  end
end

Spree::BaseHelper.include Spree::BaseHelperDecorator
