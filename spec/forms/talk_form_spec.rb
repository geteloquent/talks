require 'spec_helper'

describe TalkForm do
  subject { described_class.new(attributes) }
  let(:attributes) { FactoryGirl.attributes_for(:talk) }

  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_least(3) }

  it { should validate_presence_of(:slug) }
  it { should ensure_length_of(:slug).is_at_least(3) }

  it { should validate_presence_of(:description) }

  it { should validate_presence_of(:deadline) }
  it { should_not allow_value(Date.yesterday).for(:deadline) }

  # it { should ensure_length_of(:audiences).is_at_least(1) }

  describe "#submit" do
    it "invokes Talk#save" do
      expect_any_instance_of(Talk).to receive(:save)
      subject.submit
    end

    it "returns true" do
      expect(subject.submit).to be_true
    end
  end

  describe "#talk" do
    it "instantiates a new Talk the first time it's called"
    it "returns the existing Talk when called after the first time"
  end

  describe "#build_reference" do
    it "should build an empty reference"
  end

  describe "#references_attributes" do
    let(:references_attributes) do
      { "0" => FactoryGirl.attributes_for(:reference).merge!("_destroy" => "false"),
        "1" => FactoryGirl.attributes_for(:reference).merge!("_destroy" => "false"),
        "2" => FactoryGirl.attributes_for(:reference).merge!("_destroy" => "1") }
    end

    before { attributes.merge!(references_attributes: references_attributes) }

    it "should remove from the params the URLs that are blank"
    it "should remove from the params the URLs that are marked to be destroyed"
  end
end
