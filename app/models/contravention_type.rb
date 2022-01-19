class ContraventionType < ApplicationRecord

  belongs_to :contravention_group
  validates :code, :label,  presence: true
  validates_uniqueness_of :code, on: :create, message: "doit être unique"


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
