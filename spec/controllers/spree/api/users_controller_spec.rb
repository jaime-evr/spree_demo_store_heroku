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
              channel:               '1234asdf',
              password:              'spree123',
              password_confirmation: 'spree123',
              image_url:             'http://example.com/image.png'
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

    it 'returns a channel' do
      api_post :create, user_params
      expect(json_response['channel']).to eq '1234asdf'
    end

    it 'returns an image url' do
      api_post :create, user_params
      expect(json_response['image_url']).to eq 'http://example.com/image.png'
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
