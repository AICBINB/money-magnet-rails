# OpenAI class comes from 'ruby-openai' gem.
# ENV comes from 'dotenv-rails'.
# This file runs on app startup to fetch your OpenAI API key from your local .env file and configures it to be used on every call to the API

OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
end