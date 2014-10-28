require 'spec_helper'

describe Spree::Api::UsersController do
  render_views
  let(:user) { create(:user) }

  before { stub_authentication! }

  describe '#create' do
    let(:user_params) do
      {
          user: {
              email:                 'new@example.com',
              password:              'spree123',
              password_confirmation: 'spree123'
          }
      }
    end
    before {
      controller.stub(:try_spree_current_user).and_return user
    }

    it 'can create a new user' do
      api_post :create, user_params
      expect(json_response['email']).to eq 'new@example.com'
    end

    context 'when admin param is set' do
      before {
        user_params[:user][:admin] = 'true'
      }

      it 'can create a new admin user' do
        api_post :create, user_params
        expect(Spree::User.last.admin?).to be_true
      end
    end
  end
end