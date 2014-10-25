require 'spec_helper'

describe Spree::Api::MenuProductDaysController do
  render_views

  let(:user) { create(:user, email: 'spree@example.com') }
  before do
    stub_authentication!
    controller.stub(:try_spree_current_user).and_return user
  end

  describe '#create' do
    context 'when menu already exists' do
      let(:menu) { Spree::Menu.create(
          version:    1,
          start_date: Date.today.at_beginning_of_week,
          end_date:   Date.today.at_end_of_week
      ) }

      context 'when product already exists' do
        let(:product) { create(:product) }
        let(:params) do
          {
              menu_product_day: {
                  menu_id:    menu.id,
                  product_id: product.id,
                  day:        Date.today,
                  format:     :json
              }
          }
        end

        it {
          expect {
            api_post :create, params
          }.to change { Spree::MenuProductDay.count }.by 1
        }

        it 'response code is 200' do
          api_post :create, params
          expect(response.code).to eql '200'
        end
      end

      context 'when product does not exist' do
        let(:params) do
          {
              menu_product_day: {
                  menu_id:    menu.id,
                  product_id: 0,
                  day:        Date.today,
                  format:     :json
              }
          }
        end

        it {
          expect {
            api_post :create, params
          }.to change { Spree::MenuProductDay.count }.by 0
        }

        it 'response code is 422' do
          api_post :create, params
          expect(response.code).to eql '422'
        end
      end
    end

    context 'when menu does not exist' do
      context 'when product already exists' do
        let(:product) { create(:product) }
        let(:params) do
          {
              menu_product_day: {
                  menu_id:    nil,
                  product_id: product.id,
                  day:        Date.today,
                  format:     :json
              }
          }
        end

        it {
          expect {
            api_post :create, params
          }.to change { Spree::MenuProductDay.count }.by 0
        }

        it 'response code is 422' do
          api_post :create, params
          expect(response.code).to eql '422'
        end
      end

      context 'when product does not exist' do
        let(:params) do
          {
              menu_product_day: {
                  menu_id:    nil,
                  product_id: 0,
                  day:        Date.today,
                  format:     :json
              }
          }
        end

        it {
          expect {
            api_post :create, params
          }.to change { Spree::MenuProductDay.count }.by 0
        }

        it 'response code is 422' do
          api_post :create, params
          expect(response.code).to eql '422'
        end
      end
    end
  end

  describe '#create_with_products' do
    context 'when menu already exists' do
      let(:menu) { Spree::Menu.create(
          version:    1,
          start_date: Date.today.at_beginning_of_week,
          end_date:   Date.today.at_end_of_week
      ) }

      context 'when all products exist' do
        let(:products) do
          [
              create(:product), create(:product), create(:product), create(:product)
          ]
        end
        let(:params) do
          {
              menu_product_day: {
                  menu_id:     menu.id,
                  product_ids: products.map { |p| p.id },
                  day:         Date.today,
                  format:      :json
              }
          }
        end

        it {
          expect {
            api_post :create_with_products, params
          }.to change { Spree::MenuProductDay.count }.by products.size
        }

        it 'response code is 200' do
          api_post :create_with_products, params
          expect(response.code).to eql '200'
        end
      end

      context 'when some products do not exist' do
        let(:products) do
          [
              create(:product), Spree::Product.new, create(:product), Spree::Product.new
          ]
        end
        let(:params) do
          {
              menu_product_day: {
                  menu_id:     menu.id,
                  product_ids: products.map { |p| p.id },
                  day:         Date.today,
                  format:      :json
              }
          }
        end

        it {
          expect {
            api_post :create_with_products, params
          }.to change { Spree::MenuProductDay.count }.by 0
        }

        it 'response code is 422' do
          api_post :create_with_products, params
          expect(response.code).to eql '422'
        end

        it 'response error message says which product id does not exist' do
          api_post :create_with_products, params
          expect(response.body).to match /Product with id:/
        end
      end
    end

    context 'when menu does not exist' do
      context 'when all products exist' do
        let(:products) do
          [
              create(:product), create(:product), create(:product), create(:product)
          ]
        end
        let(:params) do
          {
              menu_product_day: {
                  menu_id:     nil,
                  product_ids: products.map { |p| p.id },
                  day:         Date.today,
                  format:      :json
              }
          }
        end

        it {
          expect {
            api_post :create_with_products, params
          }.to change { Spree::MenuProductDay.count }.by 0
        }

        it 'response code is 422' do
          api_post :create_with_products, params
          expect(response.code).to eql '422'
        end

        it 'response error message says menu does not exist' do
          api_post :create_with_products, params
          expect(response.body).to match /Menu with id:/
        end
      end
    end
  end
end