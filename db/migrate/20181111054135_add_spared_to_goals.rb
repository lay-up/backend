class AddSparedToGoals < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :spared, :float
  end
end
