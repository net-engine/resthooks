class SerializerFinder
  attr_accessor :resource, :version

  def initialize(args = {})
    @resource = args[:resource].to_s.underscore.pluralize
    @version = args[:version].to_i
  end

  def serializer
    "V#{version}::#{serializer_name}Serializer".constantize
  end

  private

  def serializer_name
    resource.singularize.titlecase
  end
end
