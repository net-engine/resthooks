require 'simplecov'

SimpleCov.start 'rails' do
  add_group 'Serializers', 'app/serializers'
  add_group 'Services',    'app/services'
  add_group 'Workers',     'app/workers'
end

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'database_cleaner'

Rails.logger.level = 4 # Reduce the IO during tests
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.order = 'random'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryGirl::Syntax::Methods

  config.before :suite do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each do
    DatabaseCleaner.clean
  end

  config.before do |example|
    DatabaseCleaner.start

    unless example.metadata[:enable_observer] == true
      allow_any_instance_of(ResourceObserver).to receive(:after_create)
      allow_any_instance_of(ResourceObserver).to receive(:after_save)
      allow_any_instance_of(ResourceObserver).to receive(:after_destroy)
    end
  end
end
