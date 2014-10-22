Spree::Api::ProductsController.class_eval do
  def index
    @menu_products ||= @active_menu.menu_of_the_day

    respond_with(@menu_products)
  end
end