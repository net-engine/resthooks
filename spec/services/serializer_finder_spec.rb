require 'spec_helper'

module V2
  class BeerSerializer;  end
  class BurgerSerializer;  end
end

describe SerializerFinder do
  describe ".new" do
    it "is initialized with a hash" do
      expect {
        SerializerFinder.new({})
      }.to_not raise_error
    end

    context "when given a class as a resource" do
      it "pluralises and underscores" do
        expect(SerializerFinder.new(resource: Beer).resource).to eq("beers")
      end
    end

    context "when given a singular string as a resource" do
      it "pluralises and underscores" do
        expect(SerializerFinder.new(resource: "beer").resource).to eq("beers")
      end
    end

    context "when given a string for the version number" do
      it "coerces the version to an integer" do
        expect(SerializerFinder.new(version: "1").version).to eq(1)
      end
    end
  end

  describe "#serializer" do
    let(:version) { 1 }
    let(:resource) { "beers" }
    let(:finder) { SerializerFinder.new(resource: resource, version: version) }

    it "returns a class" do
      expect(finder.serializer).to be_a_kind_of Class
    end

    it "returns the requested version" do
      expect(finder.serializer).to eq(V1::BeerSerializer)
    end

    it "can return other versions" do
      finder.version = 2

      expect(finder.serializer).not_to eq(V1::BeerSerializer)
    end

    it "doesn't return the serializer for another resource" do
      finder.resource = "burgers"

      expect(finder.serializer).not_to eq(V1::BeerSerializer)
    end
  end
end
