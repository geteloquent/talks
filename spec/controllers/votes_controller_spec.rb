require "spec_helper"

describe VotesController do
  describe "#create" do
    before { User.create }
    let(:talk) { create(:talk) }

    it "increases the likes by 1" do
      post :create, { talk_id: talk.id, vote: "like" }
      expect(talk.likes.size).to eq(1)
    end

    it "increases the votes by 1" do
      post :create, { talk_id: talk.id, vote: "like" }
      expect(talk.votes.size).to eq(1)
    end

    it "increases the dislikes by 1" do
      post :create, { talk_id: talk.id, vote: "dislike" }
      expect(talk.dislikes.size).to eq(1)
    end

    it "reditects back to the talk#show" do
      post :create, { talk_id: talk.id, vote: "dislike" }
      expect(response).to redirect_to(talk)
    end
  end
end
