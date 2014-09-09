Spree::Api::BaseController.class_eval do

  skip_before_filter :authenticate_user, if: :user_creation_controller?

  def user_creation_controller?
    req = request.path_parameters
    controller = req[:controller]
    action = req[:action]
    actions_without_token[controller] == action
  end

  private
    def actions_without_token
      {
        'spree/api/users' => 'create',
        'spree/api/products' => 'index'
      }
    end
end

