class ContraventionGroup < ApplicationRecord
  
  validates :code, presence: true
  validates_uniqueness_of :code, on: [:create, :import], message: "doit être unique"
  validates :label, presence: true
  validates :description, presence: true

  has_many :contravention_notebooks, dependent: :destroy
  has_many :contravention_types, dependent: :destroy

  before_create do 
    self.code = self.code.upcase
  end

  def attributes
    {
      'code' => nil,
      'label' => nil,
      'description' => nil
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
