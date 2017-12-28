class CreateGroupsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :groups_users, id: false do |t|
      t.references :group, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
    end
  end
end
