
class Transaction < ApplicationRecord
  belongs_to :account

  TRANSACTIONS = ['withdraw', 'deposit', 'transfer']

  validates :transfer_type, inclusion: { in: TRANSACTIONS }
  validates :amount, numericality: true

  validates :transfer_type,
            :amount,
            presence: true

  validate :check_balance
  validate :check_account_existance

  private

  # Check if transaction's ammount is bigger than account's balance
  def check_balance
    errors.add(:base, "Insufficient balance") if self.account.balance < self.amount && self.transfer_type != "deposit"
  end

  def check_account_existance
    account_to_receive = Account.find_by(account_number: self.account_to_transfer)
    errors.add(:base, "This account doesn't exist") if !account_to_receive.present? && self.transfer_type == "transfer"
  end
end
