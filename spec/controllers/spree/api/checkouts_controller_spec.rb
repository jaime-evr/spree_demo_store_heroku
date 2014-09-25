require 'spec_helper'

describe Spree::Api::CheckoutsController do
  render_views

  before(:each) do
    stub_authentication!
    Spree::Config[:track_inventory_levels] = false
    country_zone = create(:zone, :name => 'CountryZone')
    @state = create(:state)
    @country = @state.country
    country_zone.members.create(:zoneable => @country)
    create(:stock_location)

    @shipping_method = create(:shipping_method, :zones => [country_zone])
    @payment_method = create(:credit_card_payment_method)
  end

  after do
    Spree::Config[:track_inventory_levels] = true
  end

  describe '#create' do

    context 'When try a single checkout with valid params' do
      let(:variant){ create(:variant) }
      let(:user){ create(:user, :email => 'spree@example.com') }
      let(:order_params) do
        {
          id: '',
          item_total: '10.0',
          total: '12.0',
          ship_total: '12.0',
          state: 'cart',
          adjustment_total: '0.0',
          user_id: user.id,
          created_at: Time.now,
          updated_at: Time.now,
          completed_at: nil,
          payment_total: 0.0,
          shipment_state: nil,
          payment_state: nil,
          email: user.email,
          special_instructions: nil,
          channel: 'spree',
          included_tax_total: 0.0,
          additional_tax_total: 0.0,
          display_included_tax_total: '$0.00',
          display_additional_tax_total: '$0.00',
          tax_total: 0.0,
          currency: 'USD',
          display_item_total: '$0.00',
          total_quantity: 5,
          display_total: '$12.00',
          display_ship_total: '$2.00',
          display_tax_total: '$0.00',
          token: '',
          checkout_steps: [
            'address',
            'delivery',
            'complete'
          ],
          permissions: {
            can_update: true
          },
          bill_address_attributes: {
            :firstname  => 'John',
            :lastname   => 'Doe',
            :address1   => '7735 Old Georgetown Road',
            :city       => 'Bethesda',
            :phone      => '3014445002',
            :zipcode    => '20814',
            :state_id   => @state.id,
            :country_id => @country.id
          },
          ship_address_attributes: {
            :firstname  => 'John',
            :lastname   => 'Doe',
            :address1   => '7735 Old Georgetown Road',
            :city       => 'Bethesda',
            :phone      => '3014445002',
            :zipcode    => '20814',
            :state_id   => @state.id,
            :country_id => @country.id
          },
          line_items: [
            { variant_id: variant.id,
              quantity: 5,
              delivery_type: 1,
              delivery_time: Time.now
            }
          ],
          payments_attributes: [
            {
              payment_method_id: '1'
            }
          ],
          shipments: [
            {
              selected_shipping_rate_id: 1,
              id: 1
            }
          ],
          adjustments: []
        }
      end
      let(:payment_params) do
        { '1' => {
          number: '4111111111111111',
          month: '1',
          year: '2017',
          verification_value: '123',
          name: 'John Smith'
        } }
      end

      before(:each) do
        Spree::Order.any_instance.stub(:confirmation_required? => true)
        Spree::Order.any_instance.stub(:payment_required? => true)
        controller.stub(:try_spree_current_user).and_return user
        api_post :create,
          user_id: user.id,
          order: order_params,
          payment_source: payment_params
      end

      it 'returns a valid response' do
        json_response['state'].should == 'complete'
        response.status.should == 200
      end

      it 'scheduled order delyvery time per item' do
        expect(Spree::Order.last.line_items.first.delivery_time).to_not be_nil
      end
    end

  end
end
