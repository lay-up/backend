class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :description
      t.float :value
      t.date :due_on
      t.references :user, index: true

      t.timestamps
    end
  end
end
