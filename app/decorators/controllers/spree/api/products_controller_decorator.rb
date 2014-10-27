Spree::Api::ProductsController.class_eval do
  def index
    @menu_products ||= @active_menu.menu_of_the_day
    respond_with(@menu_products)
  end

  def create
    authorize! :create, Spree::Product
    params[:product][:available_on] ||= Time.now
    set_up_shipping_category

    options  = { variants_attrs: variants_params, options_attrs: option_types_params }
    @product = Spree::Core::Importer::Product.new(nil, product_params, options).create

    if @product.persisted?
      create_stock_movement if stock_param.present?
      save_product_images if images_params.present?
      respond_with(@product, :status => 201, :default_template => :show)
    else
      invalid_resource!(@product)
    end
  end

  def update
    @product = find_product(params[:id])
    authorize! :update, @product

    options  = { variants_attrs: variants_params, options_attrs: option_types_params }
    @product = Spree::Core::Importer::Product.new(@product, product_params, options).update

    if @product.errors.empty?
      update_stock_item if stock_param.present?
      save_product_images if images_params.present?
      respond_with(@product.reload, :status => 200, :default_template => :show)
    else
      invalid_resource!(@product)
    end
  end

  private

  def create_stock_movement
    stock_item = @product.stock_items.first
    stock_item.stock_movements.create quantity: stock_param.to_i if stock_item
  end

  def update_stock_item
    stock_item = @product.stock_items.first
    stock_item.stock_movements.create({
                                          quantity: stock_param.to_i - stock_item.count_on_hand
                                      }) if stock_item && stock_param.to_i != 0
  end

  def save_product_images
    images_params.each do |image_param|
      if image_param[:id].present?
        img = @product.images.find(image_param[:id])
      else
        img = @product.images.new
      end
      img.image_data(image_param)
      img.save!
    end
  end

  def stock_param
    params[:product][:stock]
  end

  def images_params
    params[:product][:images]
  end
end