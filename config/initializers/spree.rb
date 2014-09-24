Spree.config do |config|
  config.override_actionmailer_config = !Rails.env.test?
  config.allow_backorder_shipping = true

  if Rails.env.production?
    config.enable_mail_delivery   = true
    config.mail_host              = 'smtp.mandrillapp.com'
    config.mail_domain            = 'mandrillapp.com'
    config.mail_port              = 587
    config.secure_connection_type = 'TLS'
    config.mail_auth_type         = 'login'
    config.smtp_username          = ENV['MANDRILL_USERNAME']
    config.smtp_password          = ENV['MANDRILL_API_KEY']
  end
end

Spree.user_class = "Spree::LegacyUser"

if Rails.env.production?
  Spree::Image.attachment_definitions[:attachment][:path] = 'spree/products/:id/:style/:basename.:extension'
  Spree::Image.attachment_definitions[:attachment][:url] = 'spree/products/:id/:style/:basename.:extension'
end

