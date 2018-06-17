class AddResolutionToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :resolution, :integer
  end
end
