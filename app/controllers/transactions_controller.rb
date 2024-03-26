class TransactionsController < ApplicationController

  def index
    client = Plaid::PlaidApi.new
    access_token = current_user.access_token
    request = Plaid::ItemPublicTokenExchangeRequest.new
    transactions_sync_request = Plaid::TransactionsSyncRequest.new
    transactions_sync_request.access_token = access_token
    transaction_response = client.transactions_sync(transactions_sync_request)
    @transactions = transaction_response.added
  end
end
