class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.find_by("#{attribute} ILIKE '%#{value}%'")
    render json: ItemSerializer.new(item)
  end

  def index
    items = Item.where("#{attribute} ILIKE '%#{value}%'")
    render json: ItemSerializer.new(items)
  end

  def attribute
    request.query_parameters.keys[0]
  end

  def value
    request.query_parameters.values[0]
  end
end
