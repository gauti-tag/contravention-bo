class AddSlugToAuditLog < ActiveRecord::Migration[6.0]
  def change
    add_column :audit_logs, :identifier, :string
    add_index :audit_logs, :identifier, unique: true
  end
end
