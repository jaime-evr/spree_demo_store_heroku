cache [I18n.locale, root_object]
attributes :id, :number, :email, :state

child(products: :products) do
  extends "spree/api/products/show"
end
child(ship_address: :ship_address) do
  extends "spree/api/addresses/show"
end
node(:token) { |o| o.guest_token }