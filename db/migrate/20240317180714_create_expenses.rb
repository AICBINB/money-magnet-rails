class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.string :description
      t.float :current
      t.float :total
      t.boolean :recurring
      t.datetime :due
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
