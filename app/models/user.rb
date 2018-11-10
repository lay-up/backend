class User < ApplicationRecord
  validates :name, :email, :salary, presence: true
end
