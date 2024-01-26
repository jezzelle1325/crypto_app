class CreateCryptocurrencies < ActiveRecord::Migration[7.1]
  def change
    create_table :cryptocurrencies do |t|
      t.string :name
      t.decimal :price
      t.decimal :market_cap

      t.timestamps
    end
  end
end
