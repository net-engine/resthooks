class Api::V1::BeersController < Api::V1::BaseController
  def index
    respond_with beers, each_serializer: ::V1::BeerSerializer
  end

  def create
    @beer = current_user.beers.create! beer_params

    respond_with @beer, location: api_v1_beers_path, serializer: ::V1::BeerSerializer
  end

  private

  def beers
    current_user.beers
  end

  def beer_params
    params.require(:beer).permit(:deliciousness)
  end
end
