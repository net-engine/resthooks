module V1
  class ResourceSubscriptionSerializer < BaseSerializer
    attributes :id, :post_url, :version, :authentication

    def authentication
    end
  end
end
