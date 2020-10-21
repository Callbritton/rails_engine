require 'rails_helper'

RSpec.describe 'Search endpoints' do
  it 'can find a single item that contains a fragment, case insensitive' do
    id = create(:merchant).id
    item = Item.create(name: "Slingshot", unit_price: 44, description: "Won't put your eye out", merchant_id: id)
    attribute = :name
    value = "SlIN"

    get "/api/v1/items/find?#{attribute}=#{value}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    attributes = data[:attributes]

    expect(data[:id]).to eq("#{item.id}")
    expect(data[:type]).to eq('item')
    expect(attributes[:name]).to eq(item.name)
  end

  it 'can find a list of items that contains a fragment, case insensitive' do
    id1 = create(:merchant).id
    id2 = create(:merchant).id
    id3 = create(:merchant).id
    id4 = create(:merchant).id
    Item.create(name: "Slingshot", unit_price: 44, description: "Won't put your eye out", merchant_id: id1)
    Item.create(name: "Pellet Gun", unit_price: 44, description: "Won't put your eye out", merchant_id: id2)
    Item.create(name: "LaserShot", unit_price: 44, description: "Won't put your eye out", merchant_id: id3)
    Item.create(name: "Bow n' Arrow", unit_price: 44, description: "Won't put your eye out", merchant_id: id4)

    attribute = :name
    value = "ShOt"

    get "/api/v1/items/find_all?#{attribute}=#{value}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]

# Need to find additional ways to test this...
    expect(data.count).to eq(2)
  end
end
