Spree::Api::OrdersController.class_eval do
  def index
    authorize! :index, Spree::Order
    @orders = Spree::Order.where('state IN (?)', %w(confirm complete))
    respond_with(@orders)
  end

  def next_state
    find_order(true)
    authorize! :update, @order, order_token
    user_id = params[:order][:user_id]
    if current_api_user.has_spree_role?('admin') && user_id
      @order.associate_user!(Spree.user_class.find(user_id))
      if @order.next
        return respond_with(@order, default_template: :show)
      end
    end
    invalid_resource!(@order)
  end
end