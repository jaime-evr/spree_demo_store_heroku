Spree::Order.class_eval do
  def allow_cancel?
    return false unless on_cancelable_step? and state != 'canceled'
    shipment_state.nil? || %w{ready backorder pending}.include?(shipment_state)
  end

  private
    def on_cancelable_step?
      complete? || confirm?
    end
end
