# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
end

Spree.user_class = "Spree::LegacyUser"

Spree::Api::Config[:requires_authentication] = false
Spree::Config[:always_include_confirm_step] = true

if Rails.env.production? || Rails.env.staging?
  Spree::Image.attachment_definitions[:attachment][:path] = 'spree/products/:id/:style/:basename.:extension'
  Spree::Image.attachment_definitions[:attachment][:url] = 'spree/products/:id/:style/:basename.:extension'
end

