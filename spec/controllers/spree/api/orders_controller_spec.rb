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
      let!(:order_canceled) { Spree::Order.create state: 'canceled' }

      before do
        user.spree_roles.create(name: 'admin')
        api_get :index
      end

      it {
        json_response[:orders].each do |order_hash|
          expect(%w(confirm complete)).to include order_hash[:state]
        end
      }

      it { expect(json_response[:current_page]).to be_nil }
      it { expect(json_response[:pages]).to be_nil }
    end
  end

  context '#next_state' do
    context 'when user is admin' do
      let(:order) { create(:order) }
      before {
        user.spree_roles.create(name: 'admin')
      }

      context 'when order is in confirm state' do
        let(:params) {
          {
              id:    order.number,
              order: {
                  user_id: user.id
              }
          }
        }
        before do
          order.update_attribute(:state, 'confirm')
          api_put :next_state, params
        end

        it {
          expect(order.reload.state).to eql 'complete'
        }
      end
    end
  end
end