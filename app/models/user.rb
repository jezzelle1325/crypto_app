class User < ApplicationRecord
  # Association
  has_many :transactions
  has_many :cryptocurrencies, through: :transactions

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end

