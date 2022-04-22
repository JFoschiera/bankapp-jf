class AddColumnToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :user, index: true
  end
end
