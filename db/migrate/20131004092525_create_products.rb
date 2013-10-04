class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :pro_name
      t.integer :amount
      t.references :customer

      t.timestamps
    end
  end
end
