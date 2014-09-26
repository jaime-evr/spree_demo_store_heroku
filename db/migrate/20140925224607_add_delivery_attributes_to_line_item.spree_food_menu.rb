# This migration comes from spree_food_menu (originally 20140925224348)
class AddDeliveryAttributesToLineItem < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :delivery_type, :integer
    add_column :spree_line_items, :delivery_time, :datetime

    add_index :spree_line_items, :delivery_type
    add_index :spree_line_items, :delivery_time
  end
end
