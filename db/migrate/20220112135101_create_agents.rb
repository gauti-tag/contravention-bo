class CreateAgents < ActiveRecord::Migration[6.0]
  def change
    create_table :agents do |t|
      t.string :last_name
      t.string :first_name
      t.string :grade
      t.string :identifier

      t.timestamps
    end


    add_index :agents, :identifier, unique: true
    add_column :agents, :author_id, :integer, null: true, index: true
    add_foreign_key :agents, :users, column: :author_id
  end
end
