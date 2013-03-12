require "spec_helper"

describe "burgers API" do
  let!(:customer) { create(:user) }
  let(:headers)  { { 'HTTP_AUTHORIZATION' => "Token token=\"#{customer.api_token}\"", 'Accept' => 'application/json' } }

  context "when the user provides a valid API token" do
    it "responds with 200" do
      get "/api/v1/burgers.json", nil, headers

      response.should be_success
    end

    context "when the user has purchased burgers" do
      let!(:burger1) { create(:burger, user: customer) }
      let!(:burger2) { create(:burger, user: customer) }

      it "responds with a valid JSON representation" do
        get "/api/v1/burgers.json", nil, headers

        response_body = %{
          {
            "burgers": [
              {
                "id": #{burger1.id},
                "user_id": #{customer.id},
                "updated_at": "#{burger1.updated_at.iso8601}"
              },
              {
                "id": #{burger2.id},
                "user_id": #{customer.id},
                "updated_at": "#{burger2.updated_at.iso8601}"
              }
            ]
          }
        }

        JSON.parse(response.body).should == JSON.parse(response_body)
      end
    end
  end

  context "when the user does not provide a valid API token" do
    it "responds with 401" do
      get "/api/v1/burgers.json"

      response.status.should eq(401)
    end
  end
end
