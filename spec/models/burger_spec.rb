require 'spec_helper'

describe Burger, type: :model do
  it { is_expected.to belong_to(:user) }
end
