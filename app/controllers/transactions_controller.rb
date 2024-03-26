class TransactionsController < ApplicationController

  def index
    client = Plaid::PlaidApi.new
    access_token = current_user.access_token
    transactions_sync_request = Plaid::TransactionsSyncRequest.new
    transactions_sync_request.access_token = access_token
    transaction_response = client.transactions_sync(transactions_sync_request)
    @transactions = transaction_response.added
    @transactions = @transactions.reduce({}) do |reduced_transactions, transaction|
      date = transaction.date
      if reduced_transactions.has_key?(date)
        reduced_transactions[date] = -(reduced_transactions[date]  + transaction.amount)
      else
        reduced_transactions[date] = -transaction.amount
      end
      reduced_transactions
      end.sort_by{|date, _| date }
    @transactions =  calculate_balance(@transactions)
  end

  def spending
    @spending_by_month = PlaidApi.new(current_user.id).spending_by_month
  end

  private

  def calculate_balance(transactions)
    balance = 0
    balance_over_time = {}

    transactions.each do |date, amount|
      balance += amount
      balance_over_time[date] = balance
    end

    balance_over_time
  end
end
