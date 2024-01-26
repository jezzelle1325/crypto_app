class Cryptocurrency < ApplicationRecord
  # Association
  has_many :transactions

  # Validations
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :market_cap, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end

