require 'spec_helper'

describe User do
  it { should respond_to(:likes) }
  it { should respond_to(:dislikes) }
end
