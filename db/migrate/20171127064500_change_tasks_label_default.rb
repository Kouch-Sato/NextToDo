class ChangeTasksLabelDefault < ActiveRecord::Migration[5.1]
  def up
    change_column :tasks, :label, :string, null: false, default: "blue"
  end

  def down
    change_column :tasks, :label, :string
  end
end
