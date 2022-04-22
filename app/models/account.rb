class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :user, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: true
end
