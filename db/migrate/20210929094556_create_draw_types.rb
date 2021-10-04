class CreateDrawTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :draw_types do |t|
      t.string :name, null: false
      t.integer :week_day, null: false
      t.time :bets_end_at
      t.time :drawn_at
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
