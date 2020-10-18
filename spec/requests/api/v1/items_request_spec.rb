require 'rails_helper'

describe "Items API" do

  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)
    data = item[:data][0]
    attributes = data[:attributes]

    expect(data.count).to eq(3)

    expect(data).to have_key(:id)
    expect(data[:id]).to be_an(String)

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to be_a(String)

    expect(attributes).to have_key(:unit_price)
    expect(attributes[:unit_price]).to be_a(Float)
  end

  it "can get one item by it's id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)
    data = item[:data]
    attributes = data[:attributes]

    expect(response).to be_successful

    expect(data).to have_key(:id)
    expect(data[:id]).to eq(id.to_s)

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to be_a(String)

    expect(attributes).to have_key(:unit_price)
    expect(attributes[:unit_price]).to be_a(Float)

    expect(attributes).to have_key(:merchant_id)
    expect(attributes[:merchant_id]).to be_a(Integer)
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = ({
                    name: 'Totally safe slingshot',
                    description: 'Absolutely wont put your eye out!',
                    unit_price: 19.99,
                    merchant_id: merchant.id
                  })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Slightly unsafe slingshot" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Slightly unsafe slingshot")
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    # Alternative option:
    # expect{ delete "/api/v1/books/#{book.id}" }.to change(Book, :count).by(-1)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
