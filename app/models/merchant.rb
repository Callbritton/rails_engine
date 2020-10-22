class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  validates_presence_of :name

  def self.most_revenue(quantity)
    Merchant
    .joins(invoices: [:transactions, :invoice_items])
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .where("transactions.result='success' AND invoices.status='shipped'")
    .group('merchants.id')
    .order('revenue DESC')
    .limit(quantity)
  end

  def self.most_items(quantity)
    Merchant
    .joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity) AS total_items")
    .where("transactions.result='success' AND invoices.status='shipped'")
    .group("merchants.id")
    .order("total_items DESC")
    .limit(quantity)
  end
end
