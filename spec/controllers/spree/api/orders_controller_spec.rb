require 'spec_helper'

describe Spree::Api::OrdersController do
  render_views

  let(:user) { create(:user, email: 'spree@example.com') }

  before do
    stub_authentication!
    controller.stub(:try_spree_current_user).and_return user
  end

  context '#index' do
    context 'when user is admin' do
      let!(:order_confirm) { Spree::Order.create state: 'confirm' }
      let!(:order_complete) { Spree::Order.create state: 'complete' }

      before do
        user.spree_roles.create(name: 'admin')
        api_get :index
      end

      it {
        json_response[:orders].each do |order_hash|
          expect(order_hash[:state]).to eql 'confirm'
        end
      }

      it { expect(json_response[:current_page]).to be_nil }
      it { expect(json_response[:pages]).to be_nil }
    end
  end
end