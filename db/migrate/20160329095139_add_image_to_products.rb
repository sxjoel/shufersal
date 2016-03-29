class AddImageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :img, :string
  end
end
