require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items['data'].count).to eq(3)
  end
  it "can find an item by id" do
    id = create(:item).id
    get "/api/v1/items/#{id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["id"].to_i).to eq(id)
  end
  it "creates an item" do
    merchant = create(:merchant)
    item_params = {
                    name: 'New Thingy',
                    description: 'New description',
                    unit_price: 84.84,
                    merchant_id: merchant.id
                  }

    post "/api/v1/items", params: item_params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    item = Item.last

    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(merchant.id)
  end
end
