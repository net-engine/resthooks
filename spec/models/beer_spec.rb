require 'spec_helper'

describe Beer, type: :model do
  it { is_expected.to belong_to(:user) }
end
