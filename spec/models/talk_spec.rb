require 'spec_helper'

describe Talk do
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_least(3) }

  it { should validate_presence_of(:slug) }
  it { should ensure_length_of(:slug).is_at_least(3) }
  it { should validate_uniqueness_of(:slug) }

  it { should validate_presence_of(:description) }

  it { should validate_presence_of(:deadline) }

  it "doesn't have a deadline starting from at least today" do
    talk = FactoryGirl.build(:talk, deadline: "2014-01-01")
    expect(talk).not_to be_valid
  end

  it "has a deadline starting at least from today" do
    talk = FactoryGirl.build(:talk)
    expect(talk).to be_valid
  end

  it { should have_and_belong_to_many :audiences }
  it { should have_many :references }
end
