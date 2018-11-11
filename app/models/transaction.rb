class Transaction < ApplicationRecord
  belongs_to :expense, optional: true
  belongs_to :user

  validates :value, :expense, presence: true
  validates :expense, presence: true if value < 0

  def self.by_month(user_id, timespan)
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
          month, year;', user_id, timespan]
    ).as_json
  end
end
