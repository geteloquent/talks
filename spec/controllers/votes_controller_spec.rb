require "spec_helper"

describe VotesController do
  describe "#create" do
    let(:talk) { create(:talk) }
    let(:vote) { "dislike" }

    it "redirects back to the talk#show" do
      post :create, { talk_id: talk.id, vote: vote }
      expect(response).to redirect_to(talk)
    end
  end
end
