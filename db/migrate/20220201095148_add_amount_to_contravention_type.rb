class AddAmountToContraventionType < ActiveRecord::Migration[6.0]
  def change
    add_column :contravention_types, :amount, :float, default: 0.0
  end
end
