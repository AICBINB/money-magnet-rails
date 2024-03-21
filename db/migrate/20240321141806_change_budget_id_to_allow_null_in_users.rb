class ChangeBudgetIdToAllowNullInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :budget_id, true
  end
end
