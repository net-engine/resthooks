require 'spec_helper'

describe Burger do
  it { should belong_to(:user) }
end
