module V1
  class BaseSerializer < ActiveModel::Serializer
    embed :ids

    def updated_at
      object.updated_at.try(:iso8601)
    end
  end
end
