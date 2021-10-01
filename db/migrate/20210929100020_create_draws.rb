class CreateDraws < ActiveRecord::Migration[6.0]
  def change
    create_table :draws do |t|
      t.string :identifier, null: false
      t.text :draw_numbers, array: true, default: []
      t.date :published_at, null: false
      t.references :draw_type, null: false, foreign_key: true

      t.timestamps
    end

    add_index :draws, :identifier, unique: true
    add_column :draws, :author_id, :integer, null: true, index: true
    add_foreign_key :draws, :users, column: :author_id
  end
end
