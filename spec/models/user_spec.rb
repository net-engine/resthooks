require 'spec_helper'

describe User, type: :model do
  it { is_expected.to have_many(:beers) }
  it { is_expected.to have_many(:burgers) }
  it { is_expected.to have_many(:resource_subscriptions) }
end
