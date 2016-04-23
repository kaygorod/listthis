class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.string :content
      t.string :image
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
