class Game < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :history

  has_many :game_draws
  validates :name, :rating, presence: true

end
