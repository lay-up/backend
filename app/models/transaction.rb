class Transaction < ApplicationRecord
  belongs_to :expense

  validates :value, :expense, presence: true
end
