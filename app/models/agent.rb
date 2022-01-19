class Agent < ApplicationRecord

validates :last_name, :first_name, :grade, presence: :true

validates_uniqueness_of :grade, on: [:create, :update], message: "doit être unique"

=begin  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      agent = find_by_id(row["id"]) || new 
      agent.attributes = row.to_hash.slice(*accessible_attributes)
      agent.author_id = current_user
      agent.save!
    end

  end


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else
      "nok"
    end
  end
=end
 # Roo::Spreadsheet.open(file.path, extension: :xlsx)

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
