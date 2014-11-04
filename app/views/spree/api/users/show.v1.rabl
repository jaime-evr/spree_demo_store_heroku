object @user

attributes *user_attributes, :image_url, :channel
child(:bill_address => :bill_address) do
  extends "spree/api/addresses/show"
end

child(:ship_address => :ship_address) do
  extends "spree/api/addresses/show"
end
