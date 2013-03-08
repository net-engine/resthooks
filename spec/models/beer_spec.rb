require 'spec_helper'

describe Beer do
  it { should belong_to(:user) }
end
