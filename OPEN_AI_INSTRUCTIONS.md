Head on over to [OpenAI](https://platform.openai.com/account/api-keys) and grab your very own API key.

While in the root directory of the project, type `touch .env` in the console to create an env file, then paste `OPENAI_ACCESS_TOKEN=<your own super secret api key here>` into it and save.

'app/services/advice_service.rb' is where OpenAI Client instances are created. Methods can be created in here; think of each one as essentially just a prompt to be fed to ChatGPT. The return value is the response to that prompt.

'app/controllers/advice_controller.rb' is where we write actions that will instantiate an AdviceService object with the request params from the client, call the relevant method (i.e. the prompt to insert the params into), and return the generated response to the client.