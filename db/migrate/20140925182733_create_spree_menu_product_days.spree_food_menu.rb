# This migration comes from spree_food_menu (originally 20140925154816)
class CreateSpreeMenuProductDays < ActiveRecord::Migration
  def change
    create_table :spree_menu_product_days do |t|
      t.integer :menu_id
      t.date :day
      t.string :product_id

      t.timestamps
    end

    add_index :spree_menu_product_days, :menu_id
    add_index :spree_menu_product_days, :day
    add_index :spree_menu_product_days, :product_id
  end
end
