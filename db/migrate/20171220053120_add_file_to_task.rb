class AddFileToTask < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :file, :binary
  end
end
