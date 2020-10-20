require 'csv'

desc "import csv data"
task import: :environment do

  puts "Resetting database..."

  Transaction.destroy_all
  InvoiceItem.destroy_all
  Invoice.destroy_all
  Item.destroy_all
  Merchant.destroy_all
  Customer.destroy_all

# Customers:
  puts "Importing Customers..."

  file = "./db/csv_data/customers.csv"
  CSV.foreach(file, headers: true) do |row|
    Customer.create!(row.to_hash)
  end

# Merchants:
  puts "Importing Merchants..."

  file = "./db/csv_data/merchants.csv"
  CSV.foreach(file, headers: true) do |row|
    Merchant.create!(row.to_hash)
  end

# Invoices:
  puts "Importing Invoices..."

  file = "./db/csv_data/invoices.csv"
  CSV.foreach(file, headers: true) do |row|
    Invoice.create!(row.to_hash)
  end

# Transactions
  puts "Importing Transactions..."

  file = "./db/csv_data/transactions.csv"
  CSV.foreach(file, headers: true) do |row|
    Transaction.create!(row.to_hash)
  end

# Items:
  puts "Importing Items"

  file = "./db/csv_data/items.csv"
  CSV.foreach(file, headers: true) do |row|
     data = row.to_hash
     if data["unit_price"]
       data["unit_price"] = (data["unit_price"].to_f / 100).round(2)
     end
     Item.create!(data)
   end

# InvoiceItems:
  puts "Importing InvoiceItems..."

  file = "./db/csv_data/invoice_items.csv"
  CSV.foreach(file, headers: true) do |row|
    data = row.to_hash
    if data["unit_price"]
      data["unit_price"] = (data["unit_price"].to_f / 100).round(2)
    end
    InvoiceItem.create!(data)
  end

# Test if this is needed
  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  puts "All data successfully imported to database!"
end
