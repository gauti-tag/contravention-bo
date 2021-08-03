class AddProfileIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile_id, :integer
    add_foreign_key :users, :admin_profiles, column: :profile_id
  end
end
