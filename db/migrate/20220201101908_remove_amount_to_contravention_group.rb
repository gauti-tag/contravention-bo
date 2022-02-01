class RemoveAmountToContraventionGroup < ActiveRecord::Migration[6.0]
  def change
    remove_column :contravention_groups, :amount
  end
end
