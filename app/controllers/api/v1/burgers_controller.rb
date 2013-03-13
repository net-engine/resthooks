class Api::V1::BurgersController < Api::V1::BaseController
  def index
    respond_with burgers, each_serializer: ::V1::BurgerSerializer
  end

  def create
    @burger = current_user.burgers.create! burger_params

    respond_with @burger, location: api_v1_burgers_path, serializer: ::V1::BurgerSerializer
  end

  private

  def burgers
    current_user.burgers
  end

  def burger_params
    params.require(:burger).permit(:deliciousness)
  end
end
