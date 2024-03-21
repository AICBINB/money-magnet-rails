class RemoveNotNullConstraintFromEmailInUsers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :users, :budget
    add_reference :users, :budget, foreign_key: true
  end
end
