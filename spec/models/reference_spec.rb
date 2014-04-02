require 'spec_helper'

describe Reference do
  it { should validate_presence_of(:url) }
  it { should validate_uniqueness_of(:url).scoped_to(:talk_id).case_insensitive }
  it { should allow_value('http://www.google.com', 'http://bar.com/foo').for(:url) }
  it { should_not allow_value('dfsfgd').for(:url) }

  it { should belong_to(:talk) }
end
