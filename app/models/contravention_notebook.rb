class ContraventionNotebook < ApplicationRecord
  belongs_to :contravention_group

  validates :number, :label, :sheets, presence: :true
end
