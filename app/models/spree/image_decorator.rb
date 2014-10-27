Spree::Image.class_eval do
  def image_data(image_data_params = {})
    StringIO.open(Base64.strict_decode64(image_data_params[:base64])) do |data|
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = image_data_params[:file_name]
      data.content_type      = image_data_params[:content_type]
      self.attachment        = data
    end
  end
end