class ContraventionGroup < ApplicationRecord

  validates :code, :label, :amount, :description, presence: :true
  validates_uniqueness_of :code 
  validates_uniqueness_of :label
end
