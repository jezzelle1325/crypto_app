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


response = HTTParty.get('https://api.coinranking.com/v2/coins', headers: {"x-access-token": "coinrankingea0e28446d13c9aa0c5269fc241c86b64ca9ade634d8d9ef"})
if response.success?

  response['data']['coins'].each do |coin_data|
    Cryptocurrency.create(
      name: coin_data['name'],
      price: coin_data['price'],
      market_cap: coin_data['marketCap']
    )
  end
else
  puts "Failed to fetch data from CoinRanking API"
end

