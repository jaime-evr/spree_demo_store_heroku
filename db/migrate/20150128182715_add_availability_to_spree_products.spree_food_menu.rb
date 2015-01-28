# This migration comes from spree_food_menu (originally 20150128173016)
class AddAvailabilityToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :available, :boolean, default: true
  end
end
