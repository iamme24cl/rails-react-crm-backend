require('csv')

class CreateFromCSV

  def self.create_prospect_and_companies(row)
    prospect = Prospect.create(first_name: row["first_name"], last_name: row["last_name"], email: row["email"], stage: row["stage"].downcase)
    prospect.phone = row["phone"] if row["phone"]
    prospect.probability = row["probability"] if row["probability"]
    company = Company.find_or_create_by(name: row["company"].downcase) if row["company"]
    prospect.company = company if company
    prospect.save
    prospect
  end

end

filename  =  File.join Rails.root, 'db/data/crm_data.csv'
counter = 0

CSV.foreach(filename, headers: true) do |row|
  prospect = CreateFromCSV.create_prospect_and_companies(row)
  puts "#{row['email']} - #{prospect.errors.full_messages.join(",")}" if prospect.errors.any?
  counter += 1 if prospect.persisted?
end

puts "Imported #{counter} prospects"

User.create(email: "demo@user.com", password: "dslkfjdjfdk123#")
