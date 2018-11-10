class User < ApplicationRecord
  has_many :goals
  validates :name, :email, :salary, presence: true
end
