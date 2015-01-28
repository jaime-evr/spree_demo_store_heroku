# This migration comes from spree_food_menu (originally 20150128224607)
class AddAvailableHoursToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :available_from, :time
    add_column :spree_products, :available_to, :time
  end
end
