require 'csv'

desc "import csv data"
task import: :environment do

  #Customers:
  file = "./db/csv_data/customers.csv"
  CSV.foreach(file, headers: true) do |row|
    Customer.create(row.to_hash)
  end
  puts "Imported customers."
end
