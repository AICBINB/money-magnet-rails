class AdviceService
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def advise
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: "How can I best achieve my financial goals, given the following information: #{text}"}], # Required. This is the prompt. You can interpolate the data from the client request body and tinker with phrasing until you get optimal responses.
        temperature: 0.7,
    })
    response.dig("choices", 0, "message", "content")
  end

  private

  def client
    @_client ||= OpenAI::Client.new
  end
end