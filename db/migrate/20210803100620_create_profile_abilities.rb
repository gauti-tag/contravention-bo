class CreateProfileAbilities < ActiveRecord::Migration[6.0]
  def change
    create_table :profile_abilities do |t|
      t.references :admin_profile, null: false, foreign_key: true
      t.references :admin_ability, null: false, foreign_key: true

      t.timestamps
    end
  end
end
