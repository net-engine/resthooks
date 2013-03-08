class Api::V1::BeersController < Api::V1::BaseController
  def index
    respond_with beers, each_serializer: ::V1::BeerSerializer
  end

  private

  def beers
    current_user.beers
  end
end
