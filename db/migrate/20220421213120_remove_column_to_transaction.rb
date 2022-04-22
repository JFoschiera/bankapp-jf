class RemoveColumnToTransaction < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :account_to_transfer, :string
  end
end
