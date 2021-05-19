Spree::Core::Engine.add_routes do
  get '/reload-cart-form', to: 'products#reload_cart_form'
  get '/app_recently_viewed_products' => 'products#app_recently_viewed'
end
