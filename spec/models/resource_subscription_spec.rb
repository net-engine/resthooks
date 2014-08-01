require 'spec_helper'

describe ResourceSubscription, type: :model do
  it { is_expected.to belong_to(:user) }

  describe ".publish" do
    let(:arguments) { {publishable_resource: :foo, publishable_event: :bar} }
    let(:subscription) { build_stubbed(:resource_subscription) }

    before(:each) do
      allow(ResourceSubscription).to receive(:for).and_return([subscription])
      allow(subscription).to receive(:publish)
    end

    it "gets subscriptions for the publishable_resource" do
      expect(ResourceSubscription).to receive(:for).with(:foo)

      ResourceSubscription.publish(arguments)
    end

    it "instructs each subscription to publish itself with the arguments provided" do
      expect(subscription).to receive(:publish).with(arguments)

      ResourceSubscription.publish(arguments)
    end
  end

  describe ".for" do
    context "given a resource" do
      let(:user) { create(:user) }
      let(:resource) { create(:beer, user: user) }

      context "when a user has resource_subscriptions" do
        let!(:subscription1) { create(:resource_subscription, user: user) }
        let!(:subscription2) { create(:resource_subscription, user: user) }

        it "returns subscriptions for that user" do
          expect(ResourceSubscription.for(resource)).to match_array([subscription1, subscription2])
        end
      end

      context "when a user has no resource_subscriptions" do
        it "returns an empty collection" do
          expect(ResourceSubscription.for(resource)).to eq([])
        end
      end
    end
  end

  describe "#publish" do
    let(:publishable_resource) { build_stubbed(:beer) }
    let(:arguments) { {publishable_resource: publishable_resource, publishable_event: "updated"} }
    let(:subscription) { build_stubbed(:resource_subscription) }

    before(:each) do
      allow(NotificationWorker).to receive(:perform_async)
    end

    context "when the subscription applies to the publishable resource" do
      context "when the subscription applies to the publishable event" do
        it "adds a worker to deliver the notification" do
          expect(NotificationWorker).to receive(:perform_async)

          subscription.publish(arguments)
        end

        it "gives the worker an appropriate JSON payload" do
          allow_any_instance_of(V1::NotificationSerializer).to receive(:to_json).and_return("foo")
          expect(NotificationWorker).to receive(:perform_async).with(hash_including(payload: "foo"))

          subscription.publish(arguments)
        end

        it "gives the worker an appropriate URL" do
          expect(NotificationWorker).to receive(:perform_async).with(hash_including(url: subscription.post_url))

          subscription.publish(arguments)
        end
      end
    end

    context "when the subscription does not apply to the publishable resource" do
      let(:subscription) { build_stubbed(:resource_subscription, subscribed_resource: "burgers") }

      context "when the subscription applies to the publishable event" do
        it "adds a worker to deliver the notification" do
          expect(NotificationWorker).not_to receive(:perform_async)

          subscription.publish(arguments)
        end
      end
    end
  end
end
