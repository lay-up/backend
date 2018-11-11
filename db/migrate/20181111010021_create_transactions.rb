class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.float :value
      t.references :user, foreign_key: true
      t.references :expense, foreign_key: true

      t.timestamps
    end
  end
end
