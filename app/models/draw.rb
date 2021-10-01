class Draw < ApplicationRecord
  @@log_title= "Tirage de jeux"

  belongs_to :draw_type
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', optional: true

  validates :draw_numbers, :published_at, presence: true
  validates :identifier, presence: true, uniqueness: true

  def title
    draw_type.try(:title)
  end

  def drawn_at
    draw_type.try(:drawn_at)
  end

end
