Spree::Api::UsersController.class_eval do
  def create
    authorize! :create, Spree.user_class
    @user = Spree.user_class.new(user_params)
    if @user.save && @user.generate_spree_api_key!
      add_spree_key_attributes
      respond_with(@user, :status => 201, :default_template => :show)
    else
      invalid_resource!(@user)
    end
  end

  private
    def add_spree_key_attributes
      Spree::Api::ApiHelpers.user_attributes << 'spree_api_key'
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end

