class PlaidApi
  attr_reader :link_token

  def initialize(user_id)
    @client = Plaid::PlaidApi.new
    @user_id = user_id
  end

  def link_token
    # Create the link_token with all of your configurations
    link_token_create_request = Plaid::LinkTokenCreateRequest.new({
      :user => { :client_user_id => user_id.to_s },
      :client_name => 'My app',
      :products => %w[auth transactions],
      :country_codes => ['US'],
      :language => 'en'
    })

    link_token_response = @client.link_token_create(
      link_token_create_request
    )

    # Pass the result to your client-side app to initialize Link
    #  and retrieve a public_token
    @link_token = link_token_response.link_token
  end

  def spending_by_month
    transactions_get_request = Plaid::TransactionsGetRequest.new
    transactions_get_request.access_token = User.find_by_id(@user_id).access_token
    transactions_get_request.start_date = Date.today.prev_month(6)
    transactions_get_request.end_date = Date.today
    response = @client.transactions_get(transactions_get_request)
    @transactions = response.transactions
    @transactions = @transactions.reduce({}) do |reduced_transactions, transaction|
      date = transaction.date.strftime("%B")
      if reduced_transactions.has_key?(date)
        reduced_transactions[date] = (reduced_transactions[date]  + transaction.amount) if transaction.amount > 0
      else
        reduced_transactions[date] = transaction.amount if transaction.amount > 0
      end
      reduced_transactions
      end.to_a.reverse
    @transactions
  end


  def transactions
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
