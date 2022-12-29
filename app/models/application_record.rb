class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include ActiveModel::Serialization
  #include GenerateCsv
  @@log_title = ''

  IGNORED_MODELS_LOG = ['AuditLog', 'AdminAbility', 'ProfileAbility', 'Game']

  after_save :save_log
  after_validation :save_error

  def self.log_title
    @@log_title
  end

  def save_log
    return if IGNORED_MODELS_LOG.include?(self.class.name) || try(:author).blank?

    log = AuditLog.new(module_title: self.class.log_title, user_id: author.id, user_ip: author.current_sign_in_ip)
    log.description = "#{log_action} #{self.class.log_title.upcase} | #{inspect}"
    log.save
  end

  def save_error
    return if IGNORED_MODELS_LOG.include?(self.class.name) || errors.empty?
    return if try(:author).blank?

    log = AuditLog.new(module_title: self.class.log_title, user_id: author.id, user_ip: author.current_sign_in_ip, tag: 2)
    log.description = "#{log_action} #{self.class.log_title.upcase} | #{errors.messages}"
    log.save
  end

  def log_action
    created_at == updated_at ? 'Création' : 'Modification'
  end

end
