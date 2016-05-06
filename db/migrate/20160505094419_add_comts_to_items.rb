class AddComtsToItems < ActiveRecord::Migration
  def change
    add_column :items, :comts, :integer
  end
end
