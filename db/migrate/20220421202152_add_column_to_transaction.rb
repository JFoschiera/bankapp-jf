class AddColumnToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :account_to_transfer, :string
  end
end
