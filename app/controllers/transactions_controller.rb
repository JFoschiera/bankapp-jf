class TransactionsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @transactions = Transaction.all
    @account = Account.find(params[:account_id])
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
      check_transfer_type(@transaction)
      redirect_to account_path(@account), notice: 'Transaction was successfully concluded.'
    else
      render :new
    end

  end

  private

  # to determine weather it will add or remove value from bank accounts
  def check_transfer_type(transaction)
    account = Account.find(params[:account_id])
    @account_to_receive = Account.find_by(account_number: transaction.account_to_transfer)
    balance = transaction.account.balance

    if transaction.transfer_type == "deposit"
      balance += transaction.amount
    elsif transaction.transfer_type == "withdraw"
      balance -= transaction.amount
    elsif transaction.transfer_type == "transfer"
      balance -= transaction.amount
      @account_to_receive.balance += transaction.amount
      @account_to_receive.save
    elsif account == @account_to_receive
      balance
    end

    account.balance = balance
    account.save
  end

  def transaction_params
    params.require(:transaction).permit(
      :transfer_type,
      :amount,
      :account_id,
      :account_to_transfer
    )
  end
end
