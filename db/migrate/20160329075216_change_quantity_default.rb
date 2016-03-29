class ChangeQuantityDefault < ActiveRecord::Migration
  def change
    change_column :user_products, :quantity, :integer, :default => 0
  end
end
