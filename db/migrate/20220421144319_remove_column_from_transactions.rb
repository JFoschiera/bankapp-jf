class RemoveColumnFromTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_reference :transactions, :user, index: true
  end
end
