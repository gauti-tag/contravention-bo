class GameDraw < ApplicationRecord
  @@log_title= "Tirage de jeux"

  belongs_to :game
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', optional: true

  validates :balls, :published_at, :drawn_at, presence: true
  validates :identifier, presence: true, uniqueness: true

  before_validation :generate_identifier

  private

  def generate_identifier
    return if identifier.present?

    self.identifier = (published_at.to_time.to_i.to_s + drawn_at.to_i.to_s + game_id.to_s)
  end
end
