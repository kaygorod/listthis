class AddViewsToLists < ActiveRecord::Migration
  def change
    add_column :lists, :views, :integer
  end
end
