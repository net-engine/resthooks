class Api::V1::ResourceSubscriptionsController < Api::V1::BaseController
  def index
    respond_with resource_subscriptions, each_serializer: ::V1::ResourceSubscriptionSerializer
  end

  def create
    @beer = current_user.resource_subscriptions.create! resource_subscription_params

    respond_with @resource_subscription, 
                 location: api_v1_resource_subscriptions_path, 
                 serializer: ::V1::ResourceSubscriptionSerializer
  end

  private

  def resource_subscriptions
    current_user.resource_subscriptions
  end

  def resource_subscription_params
    params.require(:resource_subscription).permit(:post_url, :version, :subscribed_resource)
  end
end
