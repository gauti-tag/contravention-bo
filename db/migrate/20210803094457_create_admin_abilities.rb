class CreateAdminAbilities < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_abilities do |t|
      t.string :title, limit: 120, null: false
      t.string :slug
      t.string :controller_name, limit: 120, default: ""
      t.string :action_name, limit: 120, default: ""

      t.timestamps
    end
    add_index :admin_abilities, :slug, unique: true
  end
end
