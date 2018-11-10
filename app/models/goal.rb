class Goal < ApplicationRecord
  belongs_to :user
  validates :description, :value, :due_on, :user, presence: true
end
