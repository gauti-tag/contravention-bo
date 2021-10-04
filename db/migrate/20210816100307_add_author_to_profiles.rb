class AddAuthorToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_profiles, :author_id, :integer, null: true, index: true
    add_foreign_key :admin_profiles, :users, column: :author_id
  end
end
