class CreateGameDraws < ActiveRecord::Migration[6.0]
  def change
    create_table :game_draws do |t|
      t.text :balls, array: true, default: []
      t.date :published_at, null: false
      t.time :drawn_at, null: false
      t.string :identifier, null: false
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end

    add_column :game_draws, :author_id, :integer, null: true, index: true
    add_foreign_key :game_draws, :users, column: :author_id
    add_index :game_draws, :identifier, unique: true
  end
end
