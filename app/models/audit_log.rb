class AuditLog < ApplicationRecord
  attr_readonly :identifier

  
  @@log_title= "Logs"

  belongs_to :user

  validates :module_title, :description, presence: true

  enum tag: [:info_log, :warning_log, :error_log]

  before_create :set_idenitifer

  def tag_title
    {
      'info_log' => "INFO",
      'warning_log' => "WARN",
      'error_log' => "ERROR"
    }.fetch(tag, '')
  end

  def truncate_description
    text = description.to_s.split(' ')
    return text.first if text.size == 1

    text = text.first(7).join(' ')
    "#{text}..."
  end

  private

  def set_idenitifer
    self.identifier = SecureRandom.uuid
  end
end
