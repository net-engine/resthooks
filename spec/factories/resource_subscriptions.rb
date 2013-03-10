# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource_subscription do
    user nil
    post_url "MyString"
    version 1
    resource "MyString"
  end
end
