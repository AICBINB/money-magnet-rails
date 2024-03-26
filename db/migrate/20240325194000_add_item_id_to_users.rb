class AddItemIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :item_id, :string
  end
end
