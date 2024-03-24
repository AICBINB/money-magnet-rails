puts "Clearing database..."

Budget.destroy_all
User.destroy_all
Goal.destroy_all
Expense.destroy_all

puts "Seeding budgets..."

b1 = Budget.create(amount: 2500.00)

puts "Seeding users..."

kara = User.create(email: 'moneyluvr@moneymagnet.com', encrypted_password: 'demo123', first_name: 'Kara', last_name: "Flynn", role: "", access_token: "", budget_id: b1.id)

puts "Seeding expenses..."

kara.expenses.create([
  {
    description: "",
    current: 0.0,
    total: 0.0,
    recurring: true,
    due: DateTime.new(2024, 4, 21)
  },
  {
    description: "",
    current: 0.0,
    total: 0.0,
    recurring: true,
    due: DateTime.new(2024, 4, 21)
  }
])

puts "Seeding goals..."

kara.expenses.create([
  {
    description: "",
    current: 0.0,
    total: 0.0
  },
  {
    description: "",
    current: 0.0,
    total: 0.0
  }
])

puts "Done!"