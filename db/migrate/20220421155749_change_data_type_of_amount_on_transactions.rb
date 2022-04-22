class ChangeDataTypeOfAmountOnTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :amount
    add_column :transactions, :amount, :float
  end
end
