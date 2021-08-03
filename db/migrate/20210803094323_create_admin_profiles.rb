class CreateAdminProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_profiles do |t|
      t.string :title, limit: 120, null: false
      t.string :slug

      t.timestamps
    end
    add_index :admin_profiles, :slug, unique: true
  end
end
