class ChangeDatatypeLabelOfTasks < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :label, :string
  end
end
