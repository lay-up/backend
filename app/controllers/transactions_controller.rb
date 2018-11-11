class TransactionsController < ApplicationController
  def totals
    render json: GoalService.new.totals(params[:user_id])
  end
end
