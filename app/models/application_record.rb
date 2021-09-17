class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  @@log_title= ""

  IGNORED_MODELS_LOG = ['AuditLog', 'AdminAbility', 'ProfileAbility', 'Game']

  after_save :save_log
  after_validation :save_error

  protected

  def self.log_title
    @@log_title
  end

  def save_log
    return if (IGNORED_MODELS_LOG.include?(self.class.name) || self.try(:author).blank?)
    log = AuditLog.new(module_title: self.class.log_title, user_id: self.author.id, user_ip: self.author.current_sign_in_ip)
    log.description = "#{log_action} #{self.class.log_title.upcase} | #{self.inspect}"
    log.save
  end

  def save_error
    return if (IGNORED_MODELS_LOG.include?(self.class.name) || self.errors.empty?)
    return if self.try(:author).blank?
    log = AuditLog.new(module_title: self.class.log_title, user_id: self.author.id, user_ip: self.author.current_sign_in_ip, tag: 2)
    log.description = "#{log_action} #{self.class.log_title.upcase} | #{self.errors.messages}"
    log.save
  end

  def log_action
    self.created_at == self.updated_at ? 'Création' : 'Modification'
  end

end
