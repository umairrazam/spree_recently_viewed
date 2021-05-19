module Spree::ProductsControllerDecorator
  def self.prepended(base)
    base.include Spree::RecentlyViewedProductsHelper
    base.helper_method [:cached_recently_viewed_products, :cached_recently_viewed_products_ids]
    base.before_action :set_current_order, except: :app_recently_viewed
    base.before_action :save_recently_viewed, only: :app_recently_viewed
  end

  def reload_cart_form
    load_product
    @taxon = params[:taxon_id].present? ? Spree::Taxon.find(params[:taxon_id]) : @product.taxons.first
    @product_summary = Spree::ProductSummaryPresenter.new(@product).call
    @product_properties = @product.product_properties.includes(:property)
    @product_price = @product.price_in(current_currency).amount
    load_variants
    @product_images = product_images(@product, @variants)
  end

  def app_recently_viewed
    render partial: 'spree/shared/list_recently_viewed_products', layout: false
  end

  private

  def save_recently_viewed
    id = params[:product_id]
    return unless id.present?

    rvp = (cookies['recently_viewed_products'] || '').split(', ')
    rvp.delete(id)
    rvp << id unless rvp.include?(id.to_s)
    rvp_max_count = 10
    rvp.delete_at(0) if rvp.size > rvp_max_count.to_i
    cookies['recently_viewed_products'] = rvp.join(', ')
  end
end

Spree::ProductsController.prepend Spree::ProductsControllerDecorator
