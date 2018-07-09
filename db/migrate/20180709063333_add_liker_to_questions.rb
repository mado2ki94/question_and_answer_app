class AddLikerToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :liker, :integer, default: 0
  end
end
