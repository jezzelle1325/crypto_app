class AddInterestLevelToWatchedCryptocurrencies < ActiveRecord::Migration[7.1]
  def change
    add_column :watched_cryptocurrencies, :interest_level, :string
  end
end
