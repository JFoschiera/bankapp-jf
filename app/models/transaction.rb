class Transaction < ApplicationRecord
  belongs_to :account

  TRANSACTIONS = ['withdraw', 'deposit', 'transfer']

  validates :transfer_type, inclusion: { in: TRANSACTIONS }
  validates :amount, numericality: true

  validates :transfer_type,
            :amount,
            presence: true
end
