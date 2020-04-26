class Stock < ApplicationRecord
  belongs_to :user
  has_many :trades
  
  validates :code, :name, presence: true
  validates :code, uniqueness: true
end
