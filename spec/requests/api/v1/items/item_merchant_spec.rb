require 'rails_helper'

RSpec.describe 'Relationships' do
  it 'can get merchant for an item' do
    item = create(:item)
    merchant = item.merchant

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant = JSON.parse(response.body, symbolize_names: true)
    data = merchant[:data][0]
    attributes = data[:attributes]

    expect(merchant[:data][:id]).to eq(merchant.id.to_s)
    expect(attributes[:name]).to eq(merchant.name)
  end
end
