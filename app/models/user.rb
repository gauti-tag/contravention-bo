class User < ApplicationRecord
  @@log_title= "Utilisateurs"

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable,
         :timeoutable, authentication_keys: [:login]


  EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i
  PHONE_NUMBER_REGEX = /^([0-9]*)$/

  has_one_attached :avatar
  belongs_to :profile, class_name: 'AdminProfile', primary_key: 'id', foreign_key: 'profile_id', optional: true

  has_many :users_created, class_name: "User", foreign_key: "author_id"
  belongs_to :author, class_name: "User", foreign_key: "author_id", optional: true

  enum account_status: [:pending, :active, :suspended]

  validates :email, presence: true, uniqueness: true
  validates :msisdn, presence: true, length: { minimum: 8 }, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_blank: true
  validates_format_of :email, with: EMAIL_REGEX
  validates_format_of :msisdn, with: PHONE_NUMBER_REGEX, :multiline => true

  scope :with_eager_loaded_avatar, -> { eager_load(avatar_attachment: :blob) }
  scope :with_preloaded_avatar, -> { preload(avatar_attachment: :blob) }

  after_save :set_user_profile

  attr_writer :login

  def slug_candidates
    [
      [:lastname, :firstname],
      [:lastname, :firstname, :msisdn]
    ]
  end
   
  def login
    @login || email || msisdn
  end

  def fullname
    firstname + ' ' + lastname
  end

  def profile_name
    profile.try(:title) || ''
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(email) = :value OR lower(msisdn) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:email) || conditions.has_key?(:msisdn)
      where(conditions.to_h).first
    end
  end

  # Override update_with_password method from Devise DatabaseAuthenticatable module
  # Allow current user to update his data without fill in current password
  def update_with_password(params, *options)
    
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  def is_admin?
    return false if self.profile.blank?
    self.profile.slug.eql?('administrateur')
  end

  def is_guest?
    return false if self.profile.blank?
    self.profile.slug.eql?('guest')
  end

  def has_access_to?(controller_label, action_name)
    return true if is_admin?
    return false if (profile.blank? || profile.profile_abilities.empty?)
    profile.profile_abilities.exists?(controller_name: controller_label, action_name: action_name)
  end

  def home_path
    return '/' if has_access_to?('main', 'index')
    '/users/edit'
  end

  private

  def set_user_profile
    return if profile.present?
    guest_profile = AdminProfile.friendly.find('guest')
    update(profile_id: guest_profile.id)
  rescue
    nil
  end

end
