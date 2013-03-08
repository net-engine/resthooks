module V1
  class BeerSerializer < BaseSerializer
    attributes :id
    has_one :user
  end
end
