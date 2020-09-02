require 'rails_helper'

describe "item search endpoints" do
    it 'can find a list of items that contain a fragment, case insensitive' do
      item_1 = create(:item, name: "Tiller Sponge")
      item_2 = create(:item, name: "Hilly Photo")
      item_3 = create(:item, name: "Hello")
      get '/api/v1/items/find_all?name=ILL'

      json = JSON.parse(response.body, symbolize_names: true)
      names = json[:data].map do |items|
        items[:attributes][:name]
      end
      expect(response).to be_successful
      expect(names.sort).to eq(["Hilly Photo", "Tiller Sponge"])
    end

    it 'can find a item that contain a fragment, case insensitive' do
      item_1 = create(:item, name: "Marked Fork")
      item_2 = create(:item, name: "Marker Caddy")
      item_3 = create(:item, name: "Hello")

      get '/api/v1/items/find?name=MARK'
      json = JSON.parse(response.body, symbolize_names: true)
      name = json[:data][:attributes][:name].downcase

      expect(response).to be_successful
      expect(json[:data]).to be_a(Hash)
      expect(name).to include('mark')
    end
end
