class ResourceSubscription < ActiveRecord::Base
  attr_accessor :publishable_resource, :publishable_event

  belongs_to :user

  def self.publish(args = {})
    publishable_resource = args[:publishable_resource]

    self.for(publishable_resource).each do |sub|
      sub.publish(args)
    end
  end

  def self.for(resource)
    where(user_id: resource.user_id)
  end

  def publish(args)
    @publishable_resource = args[:publishable_resource]
    @publishable_event    = args[:publishable_event]

    return unless subscription_is_applicable

    WebHookWorker.perform_async url: post_url,
                                payload: notification_payload
  end

  private

  def subscription_is_applicable
    subscription_matches_publishable_resource &&
    subscription_matches_publishable_event
  end

  def notification_payload
    notification_serializer.new(self).to_json
  end

  def notification_serializer
    SerializerFinder.new(resource: "notifications", version: version).serializer
  end

  def subscription_matches_publishable_resource
    subscribed_resource == publishable_resource.class.to_s.underscore.pluralize
  end

  def subscription_matches_publishable_event
    %W( created updated destroyed ).include? publishable_event
  end
end
