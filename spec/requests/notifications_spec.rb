require 'spec_helper'
require 'sidekiq/testing'

describe "Notifications", enable_observer: true do
  before(:each) do
    NotificationWorker.clear
    NotificationWorker.stub(:post)
  end

  let(:customer) { create(:user) }
  let(:other_customer) { create(:user) }
  let(:customer_headers)  { { 'HTTP_AUTHORIZATION' => "Token token=\"#{customer.api_token}\"", 
                     'Accept' => 'application/json' } }
  let(:other_customer_headers)  { { 'HTTP_AUTHORIZATION' => "Token token=\"#{other_customer.api_token}\"", 
                     'Accept' => 'application/json' } }

  context "when a customer subscribes to the beers resource" do
    let(:subscription) { attributes_for(:resource_subscription) }

    before(:each) do
      post "/api/v1/resource_subscriptions.json", {resource_subscription: subscription}, customer_headers
    end

    context "when this customer buys a beer" do  
      let(:beer) { attributes_for(:beer) }
      
      before(:each) do
        post "/api/v1/beers.json", {beer: beer}, customer_headers
      end

      it "posts a notification" do
        NotificationWorker.should_receive(:post)

        NotificationWorker.drain
      end
    end
    
    context "when this customer buys a burger" do  
      let(:burger) { attributes_for(:burger) }
      
      before(:each) do
        post "/api/v1/burgers.json", {burger: burger}, customer_headers
      end

      it "does not post a notification" do
        NotificationWorker.should_not_receive(:post)

        NotificationWorker.drain
      end
    end

    context "when another customer buys a beer" do  
      let(:beer) { attributes_for(:beer) }
      
      before(:each) do
        post "/api/v1/beers.json", {beer: beer}, other_customer_headers
      end

      it "does not post a notification" do
        NotificationWorker.should_not_receive(:post)

        NotificationWorker.drain
      end
    end
  end
end
