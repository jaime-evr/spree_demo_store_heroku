require 'spec_helper'

describe Spree::Order do

  describe '#allow_cancel' do
    context 'when the order is on a confirm state' do
      let(:order) { create(:order_with_line_items, state: 'confirm') }

      it 'can be canceled' do
        expect(order.allow_cancel?).to be_true
      end
    end

    context 'when the order is on a completed state' do
      let(:order) { create(:order_with_line_items, state: 'complete') }

      it 'can be canceled' do
        expect(order.allow_cancel?).to be_true
      end
    end

    context 'when the order is not confirmed or completed' do
      let(:order) { create(:order_with_line_items, state: 'address') }

      it 'can not be canceled' do
        expect(order.allow_cancel?).to be_false
      end
    end
  end
end

