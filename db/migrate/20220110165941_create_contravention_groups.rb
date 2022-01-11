class CreateContraventionGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :contravention_groups do |t|
      t.string :code, null: false, limit: 120
      t.string :label
      t.float :amount, default: 0.0
      t.text :description

      t.timestamps
    end

    add_index :contravention_groups, :code, unique: true
    add_column :contravention_groups, :author_id, :integer, null: true, index: true
    add_foreign_key :contravention_groups, :users, column: :author_id
  end
end
