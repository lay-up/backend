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