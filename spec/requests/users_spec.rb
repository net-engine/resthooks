require "spec_helper"

describe "Users API" do
  let!(:customer) { create(:user) }
  let(:headers)  { { 'HTTP_AUTHORIZATION' => "Token token=\"#{customer.api_token}\"", 'Accept' => 'application/json' } }

  context "when the user provides a valid API token" do
    it "responds with 200" do
      get "/api/v1/users.json", nil, headers

      response.should be_success
    end

    it "responds with a valid JSON representation" do
      get "/api/v1/users.json", nil, headers

      response_body = %{
        {
          "users": [
            {
              "id": #{customer.id},
              "firstname": "#{customer.firstname}",
              "lastname": "#{customer.lastname}"
            }
          ]
        }
      }

      JSON.parse(response.body).should == JSON.parse(response_body)
    end
  end

  context "when the user does not provide a valid API token" do
    it "responds with 401" do
      get "/api/v1/users.json"

      response.status.should eq(401)
    end
  end
end
