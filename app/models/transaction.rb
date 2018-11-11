class Transaction < ApplicationRecord
  belongs_to :expense
  belongs_to :usuario

  validates :value, :expense, presence: true

  def self.by_month(user_id)
    find_by_sql(
      ['select
          sum(value),
          extract(month FROM created_at) as month,
          extract(month FROM created_at) as year
        from transactions
        where
          user_id = ?
        group by
          month, year, expense_id;', user_id]
    ).as_json
  end
end
