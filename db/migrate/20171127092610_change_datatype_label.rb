class ChangeDatatypeLabel < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :label, :integer
  end
end
