class CreateBillCategories < ActiveRecord::Migration
  def change
    create_table :bill_categories do |t|
      t.integer :category_id
      t.integer :bill_id

      t.timestamps
    end
  end
end
