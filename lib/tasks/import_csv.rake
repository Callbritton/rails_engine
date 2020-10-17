require 'csv'

desc "import csv data"
task import: :environment do

# Customers:
  # file = "./db/csv_data/customers.csv"
  # CSV.foreach(file, headers: true) do |row|
  #   Customer.create(row.to_hash)
  # end
  # puts "Imported customers."

# Merchants:
  # file = "./db/csv_data/merchants.csv"
  # CSV.foreach(file, headers: true) do |row|
  #   Merchant.create(row.to_hash)
  # end
  # puts "Imported merchants."

# Invoices:
  # file = "./db/csv_data/invoices.csv"
  # CSV.foreach(file, headers: true) do |row|
  #   Invoice.create(row.to_hash)
  # end
  # puts "Imported invoices."

# Transactions
  # file = "./db/csv_data/transactions.csv"
  # CSV.foreach(file, headers: true) do |row|
  #   Transaction.create(row.to_hash)
  # end
  # puts "Imported transactions"

# Items:
   # file = "./db/csv_data/items.csv"
   # CSV.foreach(file, headers: true) do |row|
   #    data = row.to_hash
   #    if data["unit_price"]
   #      data["unit_price"] = (data["unit_price"].to_f / 100).round(2)
   #    end
   #    Item.create!(data)
   #  end
   #  puts "Imported items"

# InvoiceItems:
  # file = "./db/csv_data/invoice_items.csv"
  # CSV.foreach(file, headers: true) do |row|
  #   data = row.to_hash
  #   if data["unit_price"]
  #     data["unit_price"] = (data["unit_price"].to_f / 100).round(2)
  #   end
  #   InvoiceItem.create!(data)
  # end
  # puts "Imported invoice items."

end
