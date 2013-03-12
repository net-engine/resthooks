module V1
  class BeerSerializer < BaseSerializer
    attributes :id, :updated_at
    has_one :user
  end
end
