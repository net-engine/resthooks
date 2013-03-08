class Api::V1::BurgersController < Api::V1::BaseController
  def index
    respond_with burgers, each_serializer: ::V1::BurgerSerializer
  end

  private

  def burgers
    current_user.burgers
  end
end
