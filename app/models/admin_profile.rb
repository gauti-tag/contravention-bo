class AdminProfile < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :history
  
  has_many :users, primary_key: 'id', foreign_key: 'profile_id'
  has_many :profile_abilities
  has_many :admin_abilities, through: :profile_abilities
  validates :title, presence: true, uniqueness: true
end
