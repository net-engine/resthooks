require "spec_helper"

describe "Resource Subscriptions API", type: :request do
  let!(:customer) { create(:user) }
  let(:headers)  { { 'HTTP_AUTHORIZATION' => "Token token=\"#{customer.api_token}\"", 'Accept' => 'application/json' } }

  context "GET /api/v1/beers.json" do
    context "when the user provides a valid API token" do
      context "GET index" do
        it "responds with 200" do
          get "/api/v1/resource_subscriptions.json", nil, headers

          expect(response).to be_success
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

            expect(JSON.parse(response.body)).to eq(JSON.parse(response_body))
          end
        end
      end
    end

    context "when the user does not provide a valid API token" do
      it "responds with 401" do
        get "/api/v1/resource_subscriptions.json"

        expect(response.status).to eq(401)
      end
    end
  end

  context "POST /api/v1/resource_subscriptions.json" do
    context "with valid resource_subscription json" do
      let(:json) { %{
          {
            "resource_subscription": {
              "post_url": "http://api.example.com",
              "version": 1,
              "authentication": null,
              "subscribed_resource": "beers"
            }
          }
        } }

      it "should succeed" do
        post "/api/v1/resource_subscriptions.json", JSON.parse(json), headers

        expect(response).to be_success
      end

      it "creates a resource_subscription" do
        expect {
          post "/api/v1/resource_subscriptions.json", JSON.parse(json), headers
        }.to change(ResourceSubscription, :count).by(1)
      end

      it "allows specification of subscribed_resource" do
        post "/api/v1/resource_subscriptions.json", JSON.parse(json), headers

        expect(ResourceSubscription.last.subscribed_resource).to eq("beers")
      end
    end
  end
end
