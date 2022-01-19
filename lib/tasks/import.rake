
#require 'roo'
namespace :import do
  desc "TODO"
  task data: :environment do
   # puts 'Importing Data' # add this line
    data = Roo::Spreadsheet.open('lib/agents.xlsx') # open spreadsheet
    if data
      headers = data.row(1)
      data.each_with_index do |row, idx|
        next if idx == 0 #skip header

        # create Hash from headers an cells
        user_data = Hash
      end
    else
      puts "No"
    end
  end

end
