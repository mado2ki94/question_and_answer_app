class AddIndexToQuestionsUserId < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, [:user_id, :created_at]
  end
end
