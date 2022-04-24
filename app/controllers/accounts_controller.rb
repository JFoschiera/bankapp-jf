class AccountsController < ApplicationController
  skip_before_action :authenticate_user!


  def index
    #@account = Account.find(params[:id])
    @accounts = Account.all
    @transactions = Transaction.all
    @transaction = Transaction.new
  end

  def show
    @account = Account.find(params[:id])
    @transaction = Transaction.new
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new
    @account.user = current_user
    @account.account_number = rand(1_000_000_000_000)
    @account.balance = '0.0'.to_i

    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit(
      :user_id,
      :balance,
      :account_number
    )
  end
end
