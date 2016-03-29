class CreateUserProducts < ActiveRecord::Migration
  def change
    create_table :user_products do |t|
      t.integer :quantity
      t.integer :user_id
      t.integer :product_id

      t.timestamps null: false
    end
    # add_foreign_key :user_product, :user
    # add_foreign_key :user_product, :product
  end
end
