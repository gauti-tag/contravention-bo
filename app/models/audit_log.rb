class AuditLog < ApplicationRecord
  belongs_to :user

  enum tag: [:info_log, :warning_log, :error_log]
end
