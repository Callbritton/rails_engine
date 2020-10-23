class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.find_by("#{attribute} ILIKE '%#{value}%'")
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchants = Merchant.where("#{attribute} ILIKE '%#{value}%'")
    render json: MerchantSerializer.new(merchants)
  end

  def attribute
    request.query_parameters.keys[0]
  end

  def value
    request.query_parameters.values[0]
  end
end
