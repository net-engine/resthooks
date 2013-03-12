module V1
  class BurgerSerializer < BaseSerializer
    attributes :id, :updated_at
    has_one :user
  end
end
