require 'rails_helper'

RSpec.describe 'Search endpoints' do
  it 'can find a single merchant that contains a fragment, case insensitive' do
    merchant = Merchant.create(name: "Toy Store")
    attribute = :name
    value = "TOY ST"

    get "/api/v1/merchants/find?#{attribute}=#{value}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    attributes = data[:attributes]

    expect(data[:id]).to eq("#{merchant.id}")
    expect(data[:type]).to eq('merchant')
    expect(attributes[:name]).to eq(merchant.name)
  end
end
