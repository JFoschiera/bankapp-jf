class ChangeColorName < ActiveRecord::Migration[6.1]
  def change
    rename_column :transactions, :type, :transfer_type
  end
end
