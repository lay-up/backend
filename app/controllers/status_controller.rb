class StatusController < ApplicationController
  def update
    current_user.status.points = status_params[:points]
    current_user.status.save
    render json: current_user.status
  end

  private

  def status_params
    params.permit(:points)
  end
end
