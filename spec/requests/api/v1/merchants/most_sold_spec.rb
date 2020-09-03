require 'rails_helper'

describe "Merchant most endpoint" do
  it "can return top 2 merchants based on items sold" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)
    item3 = create(:item, merchant_id: merchant3.id)
    item4 = create(:item, merchant_id: merchant4.id)
    invoice1 = create(:invoice, merchant_id: merchant1.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id)
    invoice3 = create(:invoice, merchant_id: merchant3.id)
    invoice4 = create(:invoice, merchant_id: merchant4.id)
    create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 12)
    create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, quantity: 10)
    create(:invoice_item, invoice_id: invoice3.id, item_id: item3.id, quantity: 8)
    create(:invoice_item, invoice_id: invoice4.id, item_id: item4.id, quantity: 16)
    create(:transaction, invoice_id: invoice1.id)
    create(:transaction, invoice_id: invoice2.id)
    create(:transaction, invoice_id: invoice4.id)

    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(2)
    expect(merchants['data'].first['attributes']['id'].to_i).to eq(merchant4.id)
    expect(merchants['data'][1]['attributes']['id'].to_i).to eq(merchant1.id)
  end
end
