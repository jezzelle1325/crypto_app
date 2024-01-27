class User < ApplicationRecord

  has_many :transactions
  has_many :cryptocurrencies, through: :transactions


  has_many :watched_cryptocurrencies
  has_many :watching, through: :watched_cryptocurrencies, source: :cryptocurrency
end


