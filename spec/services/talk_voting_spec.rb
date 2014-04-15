require 'spec_helper'

describe TalkVoting do
  subject { described_class.new(talk) }
  let(:talk) { build(:talk) }
  let(:voter) { User.anonymous }
  let(:vote) { "like" }

  describe "#score" do
    it "returns a Fixnum" do
      expect(subject.score).to be_a(Fixnum)
    end
  end

  describe "#vote" do
    it "invokes Talk#vote" do
      expect(talk).to receive(:vote).with(voter: voter, vote: vote, duplicate: true)
      subject.vote(voter, vote)
    end
  end
end
