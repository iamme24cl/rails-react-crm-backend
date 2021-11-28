require('csv')


filename  =  File.join Rails.root, 'db/data/crm_data.csv'
counter = 0

CSV.foreach(filename, headers: true) do |row| 
  prospect = Prospect.create(first_name: row["first_name"], last_name: row["last_name"], email: row["email"], stage: row["stage"].downcase)
  company = Company.find_or_create_by(name: row["company"].downcase) if row["company"]
  prospect.company = company if company
  prospect.save
  puts "#{row['email']} - #{prospect.errors.full_messages.join(",")}" if prospect.errors.any?
  counter += 1 if prospect.persisted?
end

puts "Imported #{counter} prospects"
