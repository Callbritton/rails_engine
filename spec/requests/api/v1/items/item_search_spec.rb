require 'rails_helper'

RSpec.describe 'Search endpoints' do
  it 'can find a single item that contains a fragment, case insensitive' do
    id = create(:merchant).id
    item = Item.create(name: "Slingshot", unit_price: 44, description: "Won't put your eye out", merchant_id: id)
    attribute = :name
    value = "Slingshot"

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

  xit 'can find a list of items that contains a fragment, case insensitive' do
    Merchant.create(name: "Toy Store")
    Merchant.create(name: "oy StO")
    Merchant.create(name: "Bike Shop")
    Merchant.create(name: "STORE")
    Merchant.create(name: "Tire Rack")
    Merchant.create(name: "StOrAgE SHACK")

    attribute = :name
    value = "sto"

    get "/api/v1/merchants/find_all?#{attribute}=#{value}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]

# Need to find additional ways to test this...
    expect(data.count).to eq(4)
  end
end
