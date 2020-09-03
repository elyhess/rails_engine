class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    limit = params['quantity']
    render json: MerchantSerializer.new(Merchant.most_revenue(limit))
  end
end
