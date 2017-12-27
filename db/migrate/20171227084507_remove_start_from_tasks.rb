class RemoveStartFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :start, :date
  end
end
