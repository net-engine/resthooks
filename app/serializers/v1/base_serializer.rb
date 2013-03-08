module V1
  class BaseSerializer < ActiveModel::Serializer
    embed :ids
  end
end
