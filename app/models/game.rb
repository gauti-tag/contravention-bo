class Game < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :history

  validates :name, :rating, presence: true

end
