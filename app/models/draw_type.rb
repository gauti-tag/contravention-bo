class DrawType < ApplicationRecord
  include ActiveModel::Serialization

  has_many :draws
  validates :name, :week_day, :drawn_at, presence: true
  validate :day_and_hour_must_be_uniq, on: :create

  enum week_day: [:dimanche, :lundi, :mardi, :mercredi, :jeudi, :vendredi, :samedi]

  def attributes
    {
      'id' => nil,
      'name' => nil,
      'bets_end_at' => nil,
      'week_day' => nil,
      'drawn_at' => nil
    }
  end

  def title
    name + ' - ' + drawn_at.strftime('%R')
  end
  
  def draw_hour
    drawn_at.strftime('%R')
  end

  def last_identifier
    draws.where(published_at: Date.today).first.identifier
  end


  def day_and_hour_must_be_uniq
    record = DrawType.find_by(drawn_at: drawn_at, week_day: week_day)
    if record.present?
      errors.add(:duplicated_time, "Un enregistrement existe déjà à cette période!")
    end
  end
    
end
