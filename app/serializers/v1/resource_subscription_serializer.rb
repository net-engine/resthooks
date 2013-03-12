module V1
  class ResourceSubscriptionSerializer < BaseSerializer
    attributes :id, :post_url, :version, :authentication, :subscribed_resource, :updated_at

    def authentication
    end
  end
end
