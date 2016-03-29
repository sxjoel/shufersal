class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :shufersal_id
      t.string :um
      t.string :remarks

      t.timestamps null: false
    end
  end
end
