class Agent < ApplicationRecord

#validates :last_name, presence: true
#validates :first_name, presence: true
#validates :grade, presence: true
#validates :identifier, presence: true
validates_uniqueness_of :identifier, on: [:create,:import], message: "<< le N° de grade doit être unique >>"
#has_many :contravention_notebooks, dependent: :destroy
 # Roo::Spreadsheet.open(file.path, extension: :xlsx)

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    #when ".csv" then Roo::Spreadsheet.open(file.path, extension: :csv)
    when ".xls" then Roo::Spreadsheet.open(file.path, extension: :xls)
    when ".xlsx" then Roo::Spreadsheet.open(file.path, extension: :xlsx)
    else
      "nok"
    end
  end

end
