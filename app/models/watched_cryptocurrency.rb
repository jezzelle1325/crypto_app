class WatchedCryptocurrency < ApplicationRecord
  belongs_to :user
  belongs_to :cryptocurrency

  validates :interest_level, presence: true
end
