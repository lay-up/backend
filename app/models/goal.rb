class Goal < ApplicationRecord
  belongs_to :user
  validates :description, :value, :due_on, :spared, :user, presence: true

  validates :value, numericality: { greater_than: 0 }
end
