class Transaction < ApplicationRecord
  # Association
  belongs_to :cryptocurrency
  belongs_to :user

  # Validations
  validates :type, presence: true, inclusion: { in: %w[buy sell] }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end

