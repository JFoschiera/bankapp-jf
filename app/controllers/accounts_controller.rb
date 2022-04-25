class AccountsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @transactions = Transaction.all
    @transaction = Transaction.new
    @accounts = policy_scope(Account).order(created_at: :desc)
  end

  def show
    @account = Account.find(params[:id])
    @transaction = Transaction.new

    authorize @account
  end

  def new
    @account = Account.new
    
    authorize @account
  end

  def create
    @account = Account.new
    @account.user = current_user
    @account.account_number = rand(1_000_000_000_000)
    @account.balance = '0.0'.to_i

    authorize @account

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
