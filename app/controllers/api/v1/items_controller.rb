class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)
    render json: ItemSerializer.new(item) if item.save
  end

  def destroy
    render json: ItemSerializer.new(Item.find(params[:id]))
    Item.delete(params[:id])
  end

  def update
    item = Item.update(params[:id], item_params)
    render json: ItemSerializer.new(item)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
