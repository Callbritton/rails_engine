require 'rails_helper'

describe "Items API" do
  before(:each) do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)
    @data = item[:data][0]
    @attributes = @data[:attributes]
  end

  it "sends a list of items" do

    expect(@data.count).to eq(3)

    expect(@data).to have_key(:id)
    expect(@data[:id]).to be_an(String)

    expect(@attributes).to have_key(:name)
    expect(@attributes[:name]).to be_a(String)

    expect(@attributes).to have_key(:description)
    expect(@attributes[:description]).to be_a(String)

    expect(@attributes).to have_key(:unit_price)
    expect(@attributes[:unit_price]).to be_a(Float)
  end

  it "can get one item by it's id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

  end
end
