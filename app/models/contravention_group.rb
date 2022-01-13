class ContraventionGroup < ApplicationRecord

  validates :code, :label, :amount, :description, presence: :true
  validates_uniqueness_of :code 
  validates_uniqueness_of :label

  has_many :contravention_notebooks, dependent: :destroy
  has_many :contravention_types, dependent: :destroy
end
