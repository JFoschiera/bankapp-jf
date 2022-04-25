class TransactionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def create?
    record.account.user == user
  end

  def index?
    true
  end
end
