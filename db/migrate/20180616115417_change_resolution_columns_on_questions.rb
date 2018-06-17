class ChangeResolutionColumnsOnQuestions < ActiveRecord::Migration[5.2]
  def change
    change_column_default :questions, :resolution, 0
  end
end
