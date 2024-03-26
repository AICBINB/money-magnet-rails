class TransactionsController < ApplicationController

  def index
    client = Plaid::PlaidApi.new
    request = Plaid::ItemPublicTokenExchangeRequest.new
    transactions_sync_request = Plaid::TransactionsSyncRequest.new
    transactions_sync_request.access_token = access_token
    @transactions = transaction_response.added
  end
end
