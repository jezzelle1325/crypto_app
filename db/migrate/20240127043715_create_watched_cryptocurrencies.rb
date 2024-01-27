class CreateWatchedCryptocurrencies < ActiveRecord::Migration[7.1]
  def change
    create_table :watched_cryptocurrencies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cryptocurrency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
