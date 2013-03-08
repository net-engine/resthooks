module V1
  class BurgerSerializer < BaseSerializer
    attributes :id
    has_one :user
  end
end
