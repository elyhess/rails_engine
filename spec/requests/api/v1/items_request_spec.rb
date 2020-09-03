require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(3)
    expect(items[:data][0]).to have_key(:id)
    expect(items[:data][0]).to have_key(:type)
    expect(items[:data][0]).to have_key(:attributes)

    expect(items[:data][0][:attributes]).to have_key(:name)
    expect(items[:data][0][:attributes]).to have_key(:description)
    expect(items[:data][0][:attributes]).to have_key(:unit_price)
    expect(items[:data][0][:attributes]).to have_key(:merchant_id)
  end
  it "can find an item by id" do
    id = create(:item).id
    get "/api/v1/items/#{id}"

    expect(response).to be_successful
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:id].to_i).to eq(id)
    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes]).to have_key(:merchant_id)
  end
  it "creates an item" do
    merchant = create(:merchant)
    item_params = {
                    name: 'New Thingy',
                    description: 'New deets',
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
  it "destroys an item" do
    item = create(:item)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)
    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(response.body).to be_empty
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
  it "updates an item" do
   item = create(:item)
   old_name = item.name
   old_description = item.description
   old_price = item.unit_price
   item_params = {
                   name: 'Newly Updated',
                   description: 'New description',
                   unit_price: 444.44
                 }

   put "/api/v1/items/#{item.id}", params: item_params

   expect(response).to be_successful
   expect(response.status).to eq(200)

   item = Item.find(item.id)

   expect(item.name).to eq(item_params[:name])
   expect(item.description).to eq(item_params[:description])
   expect(item.unit_price).to eq(item_params[:unit_price])
   expect(item.name).to_not eq(old_name)
   expect(item.description).to_not eq(old_description)
   expect(item.unit_price).to_not eq(old_price)
 end
end
