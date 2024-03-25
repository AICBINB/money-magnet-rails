Plaid.configure do |p|
  p.server_index =  Plaid::Configuration::Environment["sandbox"]
  p.api_key["PLAID-CLIENT-ID"] = Rails.application.credentials.dig(:plaid, :customer_id)
  p.api_key["PLAID-SECRET"] = Rails.application.credentials.dig(:plaid, :secret)
end
