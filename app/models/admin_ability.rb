class AdminAbility < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :history
  
  has_many :profile_abilities
  has_many :admin_profiles, through: :profile_abilities
  validates :title, presence: true, uniqueness: true
end
