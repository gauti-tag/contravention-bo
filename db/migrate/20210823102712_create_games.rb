class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name, null: false, limit: 100
      t.float :probability, default: 0.0
      t.float :rating, null: :false, default: 1.0
      t.float :payout_rating
      t.string :slug

      t.timestamps
    end

    
    add_index :games, :slug, unique: true
  end
end
