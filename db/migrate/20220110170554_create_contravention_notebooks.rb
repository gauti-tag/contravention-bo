class CreateContraventionNotebooks < ActiveRecord::Migration[6.0]
  def change
    create_table :contravention_notebooks do |t|
      t.string :number, null: false, limit: 120
      t.string :label
      t.integer :sheets, default: 1
      t.references :contravention_group, null: false, foreign_key: true

      t.timestamps
    end

    add_index :contravention_notebooks, :number, unique: true
    add_column :contravention_notebooks, :author_id, :integer, null: true, index: true
    add_foreign_key :contravention_notebooks, :users, column: :author_id
  end
end
