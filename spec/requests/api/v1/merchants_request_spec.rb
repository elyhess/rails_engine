require 'rails_helper'

describe "Merchant API endpoints" do
  it "can get one merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes][:id]).to eq(merchant.id)
    expect(json[:data][:attributes][:name]).to eq(merchant.name)
  end
  it "can send all merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants).to be_instance_of(Hash)
    expect(merchants.keys.first).to eq(:data)
    expect(merchants[:data]).to be_an(Array)
    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data][0]).to have_key(:id)
    expect(merchants[:data][0]).to have_key(:type)
    expect(merchants[:data][0]).to have_key(:attributes)
  end
  it "can create new merchant" do
    merchant_params = {
                        name: "Buddy Barn"
                      }
    post '/api/v1/merchants', params: merchant_params
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant['data']['attributes']['name']).to eq("Buddy Barn")
  end
  it "can delete a merchant" do
    merchant = create(:merchant)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)
    expect(response).to be_successful
    expect(response.body).to be_empty
    expect(response.status).to eq(204)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
  it "can update an exisiting merchant" do
    id = create(:merchant).id
    old_name = Merchant.last.name
    merchant_params = { 'name': "Pet Shop" }

    put "/api/v1/merchants/#{id}", params: merchant_params

    expect(response).to be_successful
    result = JSON.parse(response.body)

    expect(result['data']['attributes']['name']).to eq('Pet Shop')
    expect(result['data']['attributes']['name']).to_not eq("#{old_name}")
  end
end
