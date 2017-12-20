class ChangeColumnToGroupId < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :group_id, :integer, default: 0
    remove_column :tasks, :share, :integer, default: 0, null: false  
  end
end