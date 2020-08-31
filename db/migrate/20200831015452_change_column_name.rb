class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :transactions, :creadit_card_expiration, :credit_card_expiration_date
  end
end
