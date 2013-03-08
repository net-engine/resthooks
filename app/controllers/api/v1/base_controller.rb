class Api::V1::BaseController < ActionController::Base
  before_action :restrict_access
  respond_to :json
  serialization_scope :current_user

  def current_user
    @user
  end

  rescue_from ::ActiveRecord::RecordNotFound do
    respond_with_error!(:not_found, status: :not_found)
  end

  private

  def respond_with_error!(error, options = {})
    status = options.delete(:status) || :bad_request
    location = options.delete(:location) || root_path
    response = ({ error: error, message: t("api.error.#{error}", options.delete(:message_params)) }).merge!(options)
    respond_to do |format|
      format.json { render json: response.to_json, status: status, location: location }
    end
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @user = User.find_by(api_token: token)
    end
  end
end
