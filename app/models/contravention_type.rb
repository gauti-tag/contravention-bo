class ContraventionType < ApplicationRecord

  belongs_to :contravention_group
  validates :code,  presence: true
  validates :label, presence: true
  validates :amount, presence: true
  validates_uniqueness_of :code, on: :create, message: "doit être unique"

  before_create do 
    self.code = self.code.upcase.strip
    self.label = self.label.to_s.strip
  end

  def attributes 
    {
      'code' => nil,
      'label' => nil,
      'amount' => nil,
      'status' => nil
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

end
