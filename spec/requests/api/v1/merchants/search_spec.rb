require 'rails_helper'

describe "merchant search endpoints" do
    it 'can find a list of merchants that contain a fragment, case insensitive' do
      merchant_1 = create(:merchant, name: "Silly Mailman")
      merchant_2 = create(:merchant, name: "Hillard House")
      merchant_3 = create(:merchant, name: "Hello")
      get '/api/v1/merchants/find_all?name=ILL'

      json = JSON.parse(response.body, symbolize_names: true)
      names = json[:data].map do |merchant|
        merchant[:attributes][:name]
      end
      expect(response).to be_successful
      expect(names.sort).to eq(["Hillard House", "Silly Mailman"])
    end

    it 'can find a merchants that contain a fragment, case insensitive' do
      merchant_1 = create(:merchant, name: "Tillman")
      merchant_2 = create(:merchant, name: "Hilly Hillman")
      merchant_3 = create(:merchant, name: "Hello")

      get '/api/v1/merchants/find?name=ILL'
      json = JSON.parse(response.body, symbolize_names: true)
      name = json[:data][:attributes][:name].downcase

      expect(response).to be_successful
      expect(json[:data]).to be_a(Hash)
      expect(name).to include('ill')
    end
end
