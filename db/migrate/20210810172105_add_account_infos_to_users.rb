class AddAccountInfosToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :account_status, :integer, default: 0
    add_column :users, :author_id, :integer, null: true, index: true
    add_foreign_key :users, :users, column: :author_id

  end
end
