class AddLikerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :liker, :integer, default: 0
  end
end
