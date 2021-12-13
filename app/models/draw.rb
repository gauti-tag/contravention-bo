class Draw < ApplicationRecord
  @@log_title= 'Tirage de jeux'

  belongs_to :draw_type
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', optional: true

  validates :published_at, presence: true
  validates :identifier, presence: true, uniqueness: true
  validate :date_and_hour_must_be_uniq, on: :create

  def attributes
    {
      'id' => nil,
      'published_at' => nil,
      'draw_numbers' => nil,
      'identifier' => nil
    }
  end

  def title
    draw_type.try(:title)
  end

  def drawn_at
    draw_type.try(:drawn_at)
  end

  def date_and_hour_must_be_uniq
    record = Draw.find_by(published_at: published_at, draw_type_id: draw_type_id)
    if record.present?
      errors.add(:duplicated_time, 'Un enregistrement existe déjà à cette période!')
    end
  end

end
