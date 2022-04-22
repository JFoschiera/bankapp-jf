class TransactionsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @transactions = Transaction.all
  end

  def new
    @account = Account.find(params[:account_id])
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @account = Account.find(params[:account_id])
    @transaction.account = @account
    @transaction.save

    if @transaction.save
      redirect_to account_path(@account), notice: 'Transaction was successfully concluded.'
    else
      render :new
    end
    set_transfer_type(@transaction)
  end

  def set_transfer_type(transaction)
    account = Account.find(params[:account_id])
    a = transaction.account_to_transfer
    c = Account.find_by(account_number: a)
    result = transaction.account.balance

    if transaction.transfer_type == "deposit"
      result += transaction.amount
    elsif transaction.transfer_type == "withdraw"
      result -= transaction.amount
    elsif transaction.transfer_type == "transfer"
      result -= transaction.amount
      c.balance += transaction.amount
    else
      result
    end

    account.balance = result
    c.save
    account.save
  end

  private

  def transaction_params
    params.require(:transaction).permit(
      :transfer_type,
      :amount,
      :account_id,
      :account_to_transfer
    )
  end
end
