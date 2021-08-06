class CreateAuditLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :audit_logs do |t|
      t.string :user_ip, limit: 30
      t.text :description
      t.string :module_title
      t.integer :tag, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
