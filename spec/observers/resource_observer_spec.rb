require 'spec_helper'

describe ResourceObserver, enable_observer: true do
  let(:observer) { ResourceObserver.instance }
  let(:record) { double('record') }

  before(:each) do
    allow(ResourceSubscription).to receive(:publish)
  end

  describe "#after_create" do
    it "should publish with a created event" do
      args = { publishable_resource: record, publishable_event: "created" }
      expect(ResourceSubscription).to receive(:publish).with(args)

      observer.after_create(record)
    end
  end

  describe "#after_save" do
    it "should publish with a updated event" do
      args = { publishable_resource: record, publishable_event: "updated" }
      expect(ResourceSubscription).to receive(:publish).with(args)

      observer.after_save(record)
    end
  end

  describe "#after_destroyed" do
    it "should publish with a destroyed event" do
      args = { publishable_resource: record, publishable_event: "destroyed" }
      expect(ResourceSubscription).to receive(:publish).with(args)

      observer.after_destroy(record)
    end
  end
end
