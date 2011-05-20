class AddColumnCurrencyToRate < ActiveRecord::Migration
  def self.up
    add_column :rates, :currency, :string
  end

  def self.down
    remove_column :rates, :currency
  end
end
