class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :tradingDate, :tradingType, :volume, :price, presence: true
end
