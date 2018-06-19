class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
    add_index :responses, [:user_id, :created_at]
    add_index :responses, [:question_id, :created_at]
    add_index :responses, [:answer_id, :created_at]
  end
end
