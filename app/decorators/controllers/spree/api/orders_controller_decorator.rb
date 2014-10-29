Spree::Api::OrdersController.class_eval do
  def index
    authorize! :index, Spree::Order
    @orders = Spree::Order.by_state 'confirm'
    respond_with(@orders)
  end
end