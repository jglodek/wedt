class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :bill_id
      t.decimal :cost
      t.string :name

      t.timestamps
    end
  end
end
