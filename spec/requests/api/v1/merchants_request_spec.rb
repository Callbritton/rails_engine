require 'rails_helper'

describe "Merchants API" do

  it "has a merchant index" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)
    data = merchant[:data][0]
    attributes = data[:attributes]

    expect(data.count).to eq(3)

    expect(data).to have_key(:id)
    expect(data[:id]).to be_an(String)

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)
  end

  it "has a merchant show" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)
    data = merchant[:data]
    attributes = data[:attributes]

    expect(response).to be_successful

    expect(data).to have_key(:id)
    expect(data[:id]).to eq(id.to_s)

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)
  end

  it "can create a new merchant" do
    merchant_params = {name: 'Totally safe slingshot store' }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant_params)

    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  xit "can update an existing item" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "Slightly unsafe slingshot store" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(merchant_params)

    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Slightly unsafe slingshot store")
  end

  xit "can destroy an merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    # Alternative option:
    # expect{ delete "/api/v1/books/#{book.id}" }.to change(Book, :count).by(-1)

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
