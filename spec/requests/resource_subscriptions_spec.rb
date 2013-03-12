require "spec_helper"

describe "Resource Subscriptions API" do
  let!(:customer) { create(:user) }
  let(:headers)  { { 'HTTP_AUTHORIZATION' => "Token token=\"#{customer.api_token}\"", 'Accept' => 'application/json' } }

  context "when the user provides a valid API token" do
    context "GET index" do
      it "responds with 200" do
        get "/api/v1/resource_subscriptions.json", nil, headers

        response.should be_success
      end

      context "given an existing resource_subscription" do
        let!(:resource_subscription) { create(:resource_subscription, user: customer) }

        it "responds with a valid JSON representation" do
          get "/api/v1/resource_subscriptions.json", nil, headers

          response_body = %{
            {
              "resource_subscriptions": [
                {
                  "id": #{resource_subscription.id},
                  "post_url": "#{resource_subscription.post_url}",
                  "version": #{resource_subscription.version},
                  "authentication": null,
                  "subscribed_resource": "#{resource_subscription.subscribed_resource}",
                  "updated_at": "#{resource_subscription.updated_at.iso8601}"

                }
              ]
            }
          }

          JSON.parse(response.body).should == JSON.parse(response_body)
        end
      end
    end
  end

  context "when the user does not provide a valid API token" do
    it "responds with 401" do
      get "/api/v1/resource_subscriptions.json"

      response.status.should eq(401)
    end
  end
end
