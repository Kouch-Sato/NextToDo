class AddStartToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :start, :date
  end
end
