class Cryptocurrency < ApplicationRecord
  # Association
  has_many :transactions
  has_many :users, through: :transactions
  has_many :watched_cryptocurrencies
  has_many :watchers, through: :watched_cryptocurrencies, source: :user

  # Validations
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :market_cap, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end

