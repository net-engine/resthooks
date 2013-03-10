class Api::V1::ResourceSubscriptionsController < Api::V1::BaseController
  def index
    respond_with resource_subscriptions, each_serializer: ::V1::ResourceSubscriptionSerializer
  end

  private

  def resource_subscriptions
    current_user.resource_subscriptions
  end
end
