class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.integer :shop_id
      t.text :data

      t.timestamps
    end
  end
end
