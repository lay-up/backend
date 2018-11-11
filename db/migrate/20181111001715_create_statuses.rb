class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :points, default: 0
      t.integer :level, default: 2

      t.timestamps
    end
  end
end
