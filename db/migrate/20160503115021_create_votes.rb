class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :item_id
      t.integer :user_id
      t.string :user_ip

      t.timestamps null: false
    end

    add_index :votes, [:item_id, :user_id], unique: true
    add_index :votes, [:item_id, :user_ip], unique: true
  end
end
