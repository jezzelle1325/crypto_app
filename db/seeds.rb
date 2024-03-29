# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'httparty'

# Create random users
10.times do |i|
  User.create(
    name: "User #{i + 1}",
    email: "user#{i + 1}@example.com"
  )
end

# Fetch the created users
users = User.all

# Fetch and create cryptocurrencies from CoinRanking API
response = HTTParty.get('https://api.coinranking.com/v2/coins', headers: {"x-access-token": "coinrankingea0e28446d13c9aa0c5269fc241c86b64ca9ade634d8d9ef"})
if response.success?
  response['data']['coins'].each do |coin_data|
    cryptocurrency = Cryptocurrency.create(
      name: coin_data['name'],
      price: coin_data['price'],
      market_cap: coin_data['marketCap']
    )

    # Create transactions for each cryptocurrency
    5.times do
      user = users.sample # Randomly pick a user
      transaction_type = ['Buy', 'Sell'].sample # Randomly choose a type
      amount = rand(1..100) # Random amount

      cryptocurrency.transactions.create!(
        user: user,
        crypto_type: transaction_type,
        amount: amount
      )
    end
  end
else
  puts "Failed to fetch data from CoinRanking API"
end



# Cryptocurrency.all.each do |crypto|

#
#   crypto.transactions.create(crypto_type: 'buy', amount: rand(1..100))

#
#   crypto.transactions.create(crypto_type: 'sell', amount: rand(1..100))

# end

