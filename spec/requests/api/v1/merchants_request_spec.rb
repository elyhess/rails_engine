require 'rails_helper'

describe "Merchant API endpoints" do
  it "can get one merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes][:id]).to eq(merchant.id)
    expect(json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
