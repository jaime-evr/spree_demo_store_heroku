cache [I18n.locale, root_object]
attributes :id, :number, :email, :state, :created_at, :updated_at

child(products: :products) do
  extends "spree/api/products/show"
end
child line_items: :line_items do
  extends "spree/api/line_items/show"
end
child(ship_address: :ship_address) do
  extends "spree/api/addresses/show"
end
node(:token)     { |order| order.guest_token }
node(:channel)   { |order| order.user.try(:channel) }
node(:image_url) { |order| order.user.try(:image_url) }

