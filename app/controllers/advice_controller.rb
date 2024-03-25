class AdviceController < ApplicationController
  wrap_parameters format: []
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    # @advice = AdviceService.new(advice_params).advise
    respond_to do |format| 
      format.turbo_stream do 
        render turbo_frame: turbo_stream.update(
          "Hiya",
          partial: "/advice/show",
          locals: "hello"
        )
      end
    end
  end

  private

  def advice_params
    params.permit(:text)
  end

end