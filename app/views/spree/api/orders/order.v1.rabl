cache [I18n.locale, root_object]
attributes :id, :number, :email, :ship_address

child(products: :products) do
  extends "spree/api/products/show"
end
node(:token) { |o| o.guest_token }