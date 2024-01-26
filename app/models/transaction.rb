class Transaction < ApplicationRecord
  # Association
  belongs_to :cryptocurrency
  belongs_to :user

  # Validations
  validates :crypto_type, presence: true, inclusion: { in: %w[Buy Sell] }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end

