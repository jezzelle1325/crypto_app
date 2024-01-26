class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :cryptocurrency, null: false, foreign_key: true
      t.string :crypto_type
      t.decimal :amount

      t.timestamps
    end
  end
end
