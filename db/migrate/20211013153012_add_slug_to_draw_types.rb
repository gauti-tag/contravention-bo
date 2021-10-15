class AddSlugToDrawTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :draw_types, :slug, :string, limit: 50
    add_index :draw_types, :slug, unique: true
  end
end
