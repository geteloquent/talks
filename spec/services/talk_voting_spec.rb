require 'spec_helper'

describe TalkVoting do
  let(:talk) { create(:talk) }
  let(:voter) { create(:user) }
  let(:vote) { 'like' }
  subject { described_class.new(talk, voter, vote) }

  describe '#vote' do
    context 'when user is logged in' do
      it 'invokes Talk#liked_by' do
        expect(talk).to receive('liked_by').with(voter)
        subject.vote
      end
    end

    context 'when use is not logged in' do
      let(:voter) { User.anonymous }

      it 'invokes Talk#vote' do
        expect(talk).to receive(:vote).with(voter: voter, vote: vote, \
          duplicate: true)
        subject.vote
      end
    end
  end

  describe '#notice' do
    it 'returns a String' do
      expect(subject.notice).to be_a String
    end
  end
end
