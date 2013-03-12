require 'spec_helper'

class WebHookWorker; end;

describe ResourceSubscription do
  it { should belong_to(:user) }

  describe ".publish" do
    let(:arguments) { {publishable_resource: :foo, publishable_event: :bar} }
    let(:subscription) { build_stubbed(:resource_subscription) }

    before(:each) do
      ResourceSubscription.stub(:for).and_return([subscription])
      subscription.stub(:publish)
    end

    it "gets subscriptions for the publishable_resource" do
      ResourceSubscription.should_receive(:for).with(:foo)

      ResourceSubscription.publish(arguments)
    end

    it "instructs each subscription to publish itself with the arguments provided" do
      subscription.should_receive(:publish).with(arguments)

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
          ResourceSubscription.for(resource).should =~ [subscription1, subscription2]
        end
      end
  
      context "when a user has no resource_subscriptions" do
        it "returns an empty collection" do
          ResourceSubscription.for(resource).should == []
        end
      end
    end
  end

  describe "#publish" do
    let(:publishable_resource) { build_stubbed(:beer) }
    let(:arguments) { {publishable_resource: publishable_resource, publishable_event: "updated"} }
    let(:subscription) { build_stubbed(:resource_subscription) }

    before(:each) do
      WebHookWorker.stub(:perform_async)
    end

    context "when the subscription applies to the publishable resource" do
      context "when the subscription applies to the publishable event" do
        it "adds a worker to deliver the notification" do
          WebHookWorker.should_receive(:perform_async)

          subscription.publish(arguments)
        end

        it "gives the worker an appropriate JSON payload" do
          V1::NotificationSerializer.any_instance.stub(:to_json).and_return("foo")
          WebHookWorker.should_receive(:perform_async).with(hash_including(payload: "foo"))

          subscription.publish(arguments)
        end

        it "gives the worker an appropriate URL" do
          WebHookWorker.should_receive(:perform_async).with(hash_including(url: subscription.post_url))

          subscription.publish(arguments)
        end
      end
    end

    context "when the subscription does not apply to the publishable resource" do
      let(:subscription) { build_stubbed(:resource_subscription, subscribed_resource: "burgers") }

      context "when the subscription applies to the publishable event" do
        it "adds a worker to deliver the notification" do
          WebHookWorker.should_not_receive(:perform_async)

          subscription.publish(arguments)
        end
      end
    end
  end
end
