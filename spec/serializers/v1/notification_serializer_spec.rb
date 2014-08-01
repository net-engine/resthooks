require 'spec_helper'

describe V1::NotificationSerializer do
  describe "#to_json" do
    let(:publishable_resource) { build_stubbed(:beer) }
    let(:subscription) do
      build_stubbed(:resource_subscription).tap do |sub|
        sub.publishable_resource = publishable_resource
        sub.publishable_event = "updated"
      end
    end

    let(:serializer) { V1::NotificationSerializer.new(subscription) }

    it "returns the expected JSON" do
      expected_json = %{
        {
          "notification": {
            "user_id": #{subscription.user_id},
            "subscribed_resource": "beers",
            "resource_data": {
              "id": #{publishable_resource.id},
              "updated_at": null
            },
            "resource_event": "updated"
          }
        }
      }

      expect(JSON.parse(serializer.to_json)).to eq(JSON.parse(expected_json))
    end
  end
end
