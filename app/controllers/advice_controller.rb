class AdviceController < ApplicationController
  wrap_parameters format: []

  def advise
    advice = AdviceService.new(advice_params).advise
    render json: advice.to_json, status: :ok
  end

  private

  def advice_params
    params.permit(:text)
  end

end