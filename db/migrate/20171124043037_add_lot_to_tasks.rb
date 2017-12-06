class AddLotToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :due_date, :date
    add_column :tasks, :status, :integer
    add_column :tasks, :label, :string
  end
end
