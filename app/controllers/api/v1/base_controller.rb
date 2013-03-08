class Api::V1::BaseController < ActionController::Base
  before_action :restrict_access
  respond_to :json
  serialization_scope :current_user

  def current_user
    @user
  end

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @user = User.find_by(api_token: token)
    end
  end
end
