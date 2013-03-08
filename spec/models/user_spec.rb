require 'spec_helper'

describe User do
  it { should have_many(:beers) }
  it { should have_many(:burgers) }
end
