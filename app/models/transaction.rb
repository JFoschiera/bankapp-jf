
class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :user

  TRANSACTIONS = ['withdraw', 'deposit', 'transfer']

  validates :transfer_type, inclusion: { in: TRANSACTIONS }
  validates :amount, numericality: true
  # validates_with TransactionValidator

  validates :transfer_type,
            :amount,
            presence: true

  validate :check_balance
  validate :check_account_existance

  private

  # To validate under bank account's balance if transaction's amount would be valid
  def check_balance
    errors.add(:base, "Insufficient balance") if self.account.balance < self.amount && self.transfer_type != "deposit"
  end

  def check_account_existance
    account_to_receive = Account.find_by(account_number: self.account_to_transfer)
    errors.add(:base, "This account doesn't exist") if !account_to_receive.present? && self.transfer_type == "transfer"
  end

  # def check_user
  #   errors.add(:base, "transaction not authorized") if self.account.user_id != self.user_id
  # end
end
