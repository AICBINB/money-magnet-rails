class Budget < ApplicationRecord
  has_many :users
  # has_many :expenses, through: :users // Necessary?
end
