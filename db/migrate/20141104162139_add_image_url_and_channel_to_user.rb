class AddImageUrlAndChannelToUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :image_url, :string
    add_column :spree_users, :channel, :string
  end
end
