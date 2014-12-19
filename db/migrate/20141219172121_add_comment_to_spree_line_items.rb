class AddCommentToSpreeLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :comment, :text
  end
end
