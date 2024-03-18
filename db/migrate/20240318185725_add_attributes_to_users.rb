class AddAttributesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :budget, null: false, foreign_key: true
    add_column :users, :username, :string
    add_column :users, :role, :string
    add_column :users, :access_token, :string
  end
end
