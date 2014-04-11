require 'spec_helper'

describe Talk do
  it { should have_many :references }
  it { should have_and_belong_to_many :audiences }

  it { should respond_to(:votes) }

  describe "#voting_score" do
    let(:user) { User.create }
    let(:talk) { create(:talk) }

    it "calculates the voting score accordingly (likes - dislikes)" do
      4.times { talk.vote voter: user, vote: "like", duplicate: true }
      talk.vote voter: user, vote: "dislike", duplicate: true
      expect(talk.voting_score).to eq(3)
    end
  end
end
