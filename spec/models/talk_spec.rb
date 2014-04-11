require 'spec_helper'

describe Talk do
  it { should have_many :references }
  it { should have_and_belong_to_many :audiences }

  it { should respond_to(:votes) }
end
