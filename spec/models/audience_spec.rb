require 'spec_helper'

describe Audience do
  it { should have_and_belong_to_many(:talks) }
end
