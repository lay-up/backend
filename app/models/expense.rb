class Expense < ApplicationRecord
  belongs_to :user
  validates :name, :value, :user, presence: true
end
