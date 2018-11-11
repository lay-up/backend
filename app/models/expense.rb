class Expense < ApplicationRecord
  belongs_to :user
  validates :name, :value, :user, presence: true

  scope :by_month_and_year, lambda { |month, year|
    where(
      'extract(month FROM created_at) = ? AND extract(month FROM created_at) = ?',
      month, year
    )
  }
end
