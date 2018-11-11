class Status < ApplicationRecord
  belongs_to :user

  enum level: {
    terrible: 0,
    bad: 1,
    beginner: 2,
    low: 3,
    midterm: 4,
    high: 5
  }

  validate :update_level, on: :update
  validates :points, :level, presence: true

  private

  def update_level
    case points
    when points < -200
      self.level = 0
    when -100..-1
      self.level = 1
    when 0..100
      self.level = 2
    when 101..1000
      self.level = 3
    when 1001..2000
      self.level = 4
    when points > 2000
      self.level = 5
    end
    true
  end
end
