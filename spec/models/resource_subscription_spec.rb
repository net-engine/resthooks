require 'spec_helper'

describe ResourceSubscription do
  it { should belong_to(:user) }
end
