class ExpensesController < ApplicationController

# development only; expenses will be pulled from User object
  def index
    render json: Expense.all, status: :ok
  end

  def create
    expense = current_user.expenses.create!(expense_params)
    render json: expense, status: :created
  end

  def update
    expense = current_user.expenses.find_by(id: params[:id])
    expense.update!(expense_params)
    render json: expense, status: :ok
  end

  def destroy
    expense = current_user.expenses.find_by(id: params[:id])
    expense.destroy
    head :no_content
  end

  private

  def expense_params
    params.permit(:description, :current, :total, :recurring, :due)
  end
end
