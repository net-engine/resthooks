# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beer do
    user
    deliciousness 1
  end
end
