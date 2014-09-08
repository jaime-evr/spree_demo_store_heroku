Spree::Api::BaseController.class_eval do

  skip_before_filter :authenticate_user, if: :user_creation_controller?

  def user_creation_controller?
    req = request.path_parameters
    req[:controller] === 'spree/api/users' && req[:action] == 'create'
  end
end

