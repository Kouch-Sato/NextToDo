class Addgroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :row_order, :integer
  end
end
