class CreateContraventionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :contravention_types do |t|
      t.string :code, null: false, limit: 120
      t.string :label
      t.references :contravention_group, null: false, foreign_key: true

      t.timestamps
    end

    add_index :contravention_types, :code, unique: true
    add_column :contravention_types, :author_id, :integer, null: true, index: true
    add_foreign_key :contravention_types, :users, column: :author_id
  end
end
