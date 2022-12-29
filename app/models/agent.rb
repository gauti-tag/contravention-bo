class Agent < ApplicationRecord

#validates :last_name, presence: true
#validates :first_name, presence: true
#validates :grade, presence: true
#validates :identifier, presence: true
#validates_uniqueness_of :identifier, on: [:create,:import], message: "<< le N° de grade doit être unique >>"
#has_many :contravention_notebooks, dependent: :destroy
# Roo::Spreadsheet.open(file.path, extension: :xlsx)
validate :verify_uniq_identifier, on: :create

  before_create do
     self.identifier = self.identifier.upcase
  end

  def attributes
    {
      'last_name'=> nil,
      'first_name'=> nil,
      'grade'=> nil,
      'identifier'=> nil,
      'region'=> nil
    }
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    #when ".csv" then Roo::Spreadsheet.open(file.path, extension: :csv)
    when ".xls" then Roo::Spreadsheet.open(file.path, extension: :xls)
    when ".xlsx" then Roo::Spreadsheet.open(file.path, extension: :xlsx)
    else
      "nok"
    end
  end

  def verify_uniq_identifier
    record = Agent.find_by(identifier: identifier)
    if record.present?
        errors.add(:same, 'le N° de grade doit être unique')
    end
  end
end
