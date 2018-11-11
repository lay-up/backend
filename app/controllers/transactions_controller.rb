class TransactionsController < ApplicationController

  def totals
    @totals = []
    @user = User.find(params[:user_id])
    Transaction.by_month(params[:user_id]).each do |total|
      @totals << {
        month: Date::MONTHNAMES[total['month']],
        value: @user.salary - total['sum']
      }
    end
    render json: @totals
  end
end