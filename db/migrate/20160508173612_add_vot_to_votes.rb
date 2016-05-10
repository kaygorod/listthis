class AddVotToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :vot, :string
  end
end
