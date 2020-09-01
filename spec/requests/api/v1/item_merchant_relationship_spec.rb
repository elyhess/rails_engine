require 'rails_helper'

describe 'Relationships item to merchant' do
  it 'can get merchant for an item' do
    create(:merchant, id: 11)
    create(:item, id: 209, merchant_id: 11)
    get '/api/v1/items/209/merchant'
    json = JSON.parse(response.body, symbolize_names: true)
    expected_id = '11'

    expect(json[:data][:id]).to eq(expected_id)
  end
end
