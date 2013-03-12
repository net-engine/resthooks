module V1
  class NotificationSerializer < BaseSerializer
    attributes :user_id, :subscribed_resource, :resource_data, :resource_event

    def resource_event
      object.publishable_event
    end

    def resource_data
      subscribed_resource_serializer.new(object.publishable_resource).attributes
    end

    private

    def subscribed_resource_serializer
      SerializerFinder.new(resource: object.subscribed_resource, 
                           version: object.version).serializer
    end
  end
end
