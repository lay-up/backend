class Transaction < ApplicationRecord
  belongs_to :expense
  belongs_to :user

  validates :value, :expense, presence: true

  def self.by_month(user_id)
    find_by_sql(
      ['select
          sum(value),
          cast( extract(month FROM created_at) as integer ) as month,
          cast( extract(year FROM created_at) as integer ) as year
        from transactions
        where
          user_id = ? and
          created_at >= ?
        group by
          month, year;', user_id, Date.today.beginning_of_month - 3.month]
    ).as_json
  end
end
