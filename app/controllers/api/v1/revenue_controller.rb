class Api::V1::RevenueController < ApplicationController
  def index
    render json: RevenueSerializer.new(Revenue.total_revenue_for_date_range(params['start'], params['end']))
  end
end
