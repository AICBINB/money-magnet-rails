class PlaidController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new

    render :new
  end

  def create_link_token
    client = Plaid::PlaidApi.new


    # Create the link_token with all of your configurations
    link_token_create_request = Plaid::LinkTokenCreateRequest.new({
      user: { client_user_id: params[:current_user]},
      client_name: 'Butter',
      products: %w[auth transactions identity],
      country_codes: ['US'],
      language: 'en'
    })

    response = client.link_token_create(link_token_create_request)

    # Pass the result to your client-side app to initialize Link
    #  and retrieve a public_token

    render json: response
  end

  def exchange_public_token
    client = Plaid::PlaidApi.new
    request = Plaid::ItemPublicTokenExchangeRequest.new(
    {
      public_token: params["public_token"]
    }
    )
    response = client.item_public_token_exchange(request)
    # These values should be saved to a persistent database and
    # associated with the currently signed-in user
    access_token = response.access_token
    item_id = response.item_id
    current_user.access_token = access_token
    current_user.item_id = item_id
    current_user.save

    render json: {public_token_exchange: "complete"}
  end

  def accounts
    binding.break
    client = Plaid::PlaidApi.new
    access_token = current_user.access_token
    auth_get_request = Plaid::AuthGetRequest.new({:access_token => access_token})
    response = client.auth_get(auth_get_request)
    @accounts = response.accounts

  rescue Plaid::PlaidError => e
    error_response = format_error(e)
    pretty_print_response(error_response)
    render json: error_response
  end
end
