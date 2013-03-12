class ResourceObserver < ActiveRecord::Observer
  observe :beer, :burger

  def after_create(resource)
    notify(resource, 'created')
  end

  def after_save(resource)
    notify(resource, 'updated')
  end

  def after_destroy(resource)
    notify(resource, 'destroyed')
  end

  private

  def notify(resource, event)
    ResourceSubscription.publish(publishable_resource: resource, publishable_event: event)
  end
end
