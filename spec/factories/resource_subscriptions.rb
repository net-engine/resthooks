# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource_subscription do
    user
    post_url "https://api.example.com/hook"
    version 1
    subscribed_resource "beers"
  end
end
