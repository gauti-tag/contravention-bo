class ContraventionGroup < ApplicationRecord

  validates :code, :label, :amount, :description, presence: :true
  validates_uniqueness_of :code 
  #validates_uniqueness_of :label

  has_many :contravention_notebooks, dependent: :destroy
  has_many :contravention_types, dependent: :destroy


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Spreadsheet.open(file.path, extension: :csv)
    when ".xls" then Roo::Spreadsheet.open(file.path, extension: :xls)
    when ".xlsx" then Roo::Spreadsheet.open(file.path, extension: :xlsx)
    else
      "nok"
    end
  end

end
