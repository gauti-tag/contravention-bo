class AddSlugToParameters < ActiveRecord::Migration[6.0]
  def change
     add_column :parameters, :slug, :string, limit: 50
     add_index :parameters, :slug, unique: true
  end
end
