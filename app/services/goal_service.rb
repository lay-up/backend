class GoalService
  attr_accessor :status_ok, :errors, :goal

  def initialize(params={})
    @goal_params = params[:goal]
    @config = params[:config]
    @status_ok = true
    @errors = []
  end

  def save
    ActiveRecord::Base.transaction do
      @goal = Goal.new(@goal_params)
      unless @goal.save
        @status_ok = false
        @errors = @goal.errors.full_messages
        return
      end
      save_config
      @goal
    end
  end

  def totals(user_id)
    totals = []
    user = User.find(user_id)
    Transaction.by_month(user_id, Date.today.beginning_of_month - 3.month).each do |total|
      totals << {
        month: Date::MONTHNAMES[total['month']],
        value: user.salary + total['sum']
      }
    end
    totals
  end

  def allocate_money(user_id)
    data = Date.today

    return unless data == data.end_of_month

    user = User.find(params[:user_id])
    transacoes_mes = Transaction.by_month(user_id, data.beginning_of_month).first

    if transacoes_mes['sum'].positive?
      sobra = transacoes_mes['sum'].round(2) % user.goals.count > 0

      if transacoes_mes['sum'].round(2) % user.goals.count > 0
        user.goals.first += sobra
      end

      user.goals.each do |goal|
        goal.spared += transacoes_mes['sum'].round(2) / user.goals.count
      end
    end
  end

  private

  def save_config
    @config.each do |config|
      update_expense(Expense.find(config[:id]))
    end
  end

  def update_expense(expense)
    if expense.created_at.month != Date.today.month
      expense = expense.dup
      store_errors(expense) unless expense.save
    else
      store_errors(expense) unless expense.update_attributes(value: @config[:value])
    end
  end

  def store_errors(expense)
    @status_ok = false
    @errors = expense.errors.full_messages
  end
end