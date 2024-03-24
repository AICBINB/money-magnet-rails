class GoalsController < ApplicationController
  # development only; goals will be pulled from User object
  def index
    render json: Goal.all, status: :ok
  end

  def create
    goal = current_user.goals.create!(goal_params)
    render json: goal, status: :created
  end

  def update
    goal = current_user.goals.find_by(id: params[:id])
    goal.update!(goal_params)
    render json: goal, status: :ok
  end

  def destroy
    goal = current_user.goals.find_by(id: params[:id])
    goal.destroy
    head :no_content
  end

  private

  def goal_params
    params.permit(:description, :current, :total)
  end
end
