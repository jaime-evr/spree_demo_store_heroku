Spree::Image.class_eval do
  attachment_definitions[:attachment][:styles] = {
    :mini => '48x48>',
    :small => '100x100>',
    :product => '320x320>',
    :large => '600x600>'
  }
end

