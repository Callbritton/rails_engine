require 'rails_helper'

RSpec.describe 'Relationships' do
  it 'can get items for a merchant' do
    merchant = create(:merchant)
    5.times {create(:item, merchant: merchant)}

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]

    expect(data.count).to eq(5)
  end
end
