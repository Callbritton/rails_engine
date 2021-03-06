require 'rails_helper'

RSpec.describe 'Relationships' do
  it 'can get merchant for an item' do
    item = create(:item)
    merchant = item.merchant

    get "/api/v1/items/#{item.id}/merchants"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    attributes = data[:attributes]

    expect(data[:id]).to eq(merchant.id.to_s)
    expect(attributes[:name]).to eq(merchant.name)
  end
end
