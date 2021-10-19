class AddTagToAbilities < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_abilities, :tag, :integer, default: 0
  end
end
