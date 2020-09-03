describe 'business intelligence' do
  before :each do
    customer_1 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id, created_at: "2012-03-11 15:33:57")
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id)
    item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 10.00)
    item_2 = create(:item, merchant_id: merchant_1.id, unit_price: 10.00)
    item_3 = create(:item, merchant_id: merchant_2.id, unit_price: 10.00)
    item_4 = create(:item, merchant_id: merchant_2.id, unit_price: 10.00)
    item_5 = create(:item, merchant_id: merchant_2.id, unit_price: 10.00)
    item_6 = create(:item, merchant_id: merchant_3.id, unit_price: 10.00)
    item_7 = create(:item, merchant_id: merchant_3.id, unit_price: 10.00)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_3.id)
    invoice_item_4 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_4.id)
    invoice_item_5 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_5.id)
    invoice_item_6 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_6.id)
    invoice_item_7 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_7.id)
    invoice_item_8 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_1.id)
    invoice_item_9 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_2.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "rejected")
    transaction_5 = create(:transaction, invoice_id: invoice_2.id, result: "rejected")
  end
  it 'can get merchants with most revenue' do
    get "/api/v1/merchants/most_revenue?quantity=2"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(2)
    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
  it 'can get revenue between two dates' do
    get '/api/v1/revenue?start=2012-03-09&end=2012-03-24'

    json = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
  end
end
