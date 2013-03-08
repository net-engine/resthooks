class Api::V1::UsersController < Api::V1::BaseController
  def index
    respond_with [current_user], each_serializer: ::V1::UserSerializer
  end
end
