class BudgetsController < ApplicationController

  def index
    @budgets = Budget.all, status: :ok
  end

  def create
    @budget = Budget.create!(budget_params)
  end

  def show
    @budget = Budget.find_by(id: params[:id])
  end

  def update
    if current_user.admin?
      budget = current_user.budget
      budget.update!(budget_params)
    else render json: {error: "You do not have permission to make changes to the budget!"}
    end
  end

  def destroy
    if current_user.admin?
      budget = current_user.budget
      budget.destroy
      head :no_content
    else render json: {error: "You do not have permission to make changes to the budget!"}
    end
  end

  private

  def budget_params
    params.permit(:amount, :user_id)
  end
end
