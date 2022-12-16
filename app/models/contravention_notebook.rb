class ContraventionNotebook < ApplicationRecord
  belongs_to :contravention_group
  validates :number, presence: true
  validates :label, presence: true
  validates :sheets, presence: true
  #validates_uniqueness_of :number, on: :create, message: "<< le numéro doit être unique >>"
  #validates_uniqueness_of :number, scope: :contravention_group_id, on: :create
  validate :validate_number_and_group_uniq, on: :create

  before_create do 
    self.number = self.number.upcase
  end

  def attributes 
    {
      'number' => nil,
      'label' => nil,
      'sheets' => nil
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

  def validate_number_and_group_uniq
    record = ContraventionNotebook.find_by(number: number, contravention_group_id: contravention_group_id)
    if record.present?
        errors.add(:base, "le numéro et la classe doivent être uniques")
    end
  end
end
