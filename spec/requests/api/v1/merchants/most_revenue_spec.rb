require 'rails_helper'

RSpec.describe 'Business Intelligence Endpoints' do

  it 'can return a variable number of merchants ranked by total revenue' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    merchant5 = create(:merchant)
    merchant6 = create(:merchant)

    item1 = Item.create(name: "Slingshot", unit_price: 11, description: "Won't put your eye out", merchant_id: merchant1.id)
    item2 = Item.create(name: "Pellet Gun", unit_price: 22, description: "Won't put your eye out", merchant_id: merchant2.id)
    item3 = Item.create(name: "LaserShot", unit_price: 33, description: "Won't put your eye out", merchant_id: merchant3.id)
    item4 = Item.create(name: "Bow n' Arrow", unit_price: 44, description: "Won't put your eye out", merchant_id: merchant4.id)
    item5 = Item.create(name: "Rubber Band", unit_price: 55, description: "Won't put your eye out", merchant_id: merchant5.id)
    item6 = Item.create(name: "Hot Poker", unit_price: 66, description: "Won't put your eye out", merchant_id: merchant6.id)

    invoice1 = create(:invoice, merchant_id: merchant1.id, status: 'shipped')
    invoice2 = create(:invoice, merchant_id: merchant2.id, status: 'shipped')
    invoice3 = create(:invoice, merchant_id: merchant3.id, status: 'shipped')
    invoice4 = create(:invoice, merchant_id: merchant4.id, status: 'shipped')
    invoice5 = create(:invoice, merchant_id: merchant5.id, status: 'shipped')
    invoice6 = create(:invoice, merchant_id: merchant6.id, status: 'shipped')

    create(:invoice_item, item: item1, invoice: invoice1, quantity: 10, unit_price: item1.unit_price)
    create(:invoice_item, item: item2, invoice: invoice2, quantity: 20, unit_price: item2.unit_price)
    create(:invoice_item, item: item3, invoice: invoice3, quantity: 30, unit_price: item3.unit_price)
    create(:invoice_item, item: item4, invoice: invoice4, quantity: 40, unit_price: item4.unit_price)
    create(:invoice_item, item: item5, invoice: invoice5, quantity: 50, unit_price: item5.unit_price)
    create(:invoice_item, item: item6, invoice: invoice6, quantity: 60, unit_price: item6.unit_price)


    create(:transaction, invoice_id: invoice1.id, result: 'success')
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    create(:transaction, invoice_id: invoice3.id, result: 'success')
    create(:transaction, invoice_id: invoice4.id, result: 'success')
    create(:transaction, invoice_id: invoice5.id, result: 'success')

    value = 4

    get "/api/v1/merchants/most_revenue?quantity=#{value}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    name = data[:attributes][:name]

    expect(data.count).to eq(4)
    expect(name[0]).to eq(merchant6.name)
    expect(name[1]).to eq(merchant5.name)
    expect(name[2]).to eq(merchant4.name)
    expect(name[3]).to eq(merchant3.name)
  end
end
