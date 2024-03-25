class Plaid::ApiClient
  attr_reader :link_token

  def initialize(user)
    client = Plaid::PlaidApi.new
    user = user
    client_user_id = user.id

    # Create the link_token with all of your configurations
    link_token_create_request = Plaid::LinkTokenCreateRequest.new({
      :user => { :client_user_id => client_user_id.to_s },
      :client_name => 'My app',
      :products => %w[auth transactions],
      :country_codes => ['US'],
      :language => 'en'
    })

    link_token_response = client.link_token_create(
      link_token_create_request
    )

    # Pass the result to your client-side app to initialize Link
    #  and retrieve a public_token
    @link_token = link_token_response.link_token
  end
end
