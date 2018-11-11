class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :update, :destroy]

  def index
    @goals = Goal.where(user_id: params[:user_id])

    render json: @goals
  end

  def show
    render json: @goal
  end

  def create
    @goal_service = GoalService.new(goal: goal_params, config: params[:config])
    @goal_service.save

    if @goal_service.status_ok
      render json: @goal_service.goal, status: :created
    else
      render json: @goal_service.errors, status: :unprocessable_entity
    end
  end

  def update
    if @goal.update(goal_params)
      render json: @goal
    else
      render json: @goal.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @goal.destroy
  end

  private
    def set_goal
      @goal = Goal.find(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:description, :value, :due_on, :user_id)
    end
end
