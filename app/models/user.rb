class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable,
         :timeoutable, authentication_keys: [:login]


  EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i
  PHONE_NUMBER_REGEX = /^([0-9]*)$/

  has_one_attached :avatar
  belongs_to :admin_profile, optional: true

  validates :email, presence: true, uniqueness: true
  validates :msisdn, presence: true, uniqueness: true
  validates_format_of :email, with: EMAIL_REGEX
  validates_format_of :msisdn, with: PHONE_NUMBER_REGEX, :multiline => true
  validate :validate_msisdn

  scope :with_eager_loaded_avatar, -> { eager_load(avatar_attachment: :blob) }
  scope :with_preloaded_avatar, -> { preload(avatar_attachment: :blob) }

  attr_writer :login
   
  def login
    @login || email || msisdn
  end

  def validate_msisdn
    errors.add(:msisdn, :invalid) if User.where(email: msisdn).exists?
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["msisdn = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:msisdn) || conditions.has_key?(:email)
			where(conditions.to_h).first
    end
  end

  def is_admin?
    return false if self.admin_profile.blank?
    self.admin_profile.slug.eql?('admin')
  end

  def has_access_to?(controller_label, action_name)
    return true if is_admin?
    return false if (admin_profile.blank? || admin_profile.profile_abilities.empty?)
    admin_profile.profile_abilities.exists?(controller_name: controller_label, action_name: action_name)
  end

end
