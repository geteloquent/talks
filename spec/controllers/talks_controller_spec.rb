require "spec_helper"

describe TalksController do
  describe "GET #index" do
    let(:talks) do
      3.times.map { |i| create(:talk, deadline: Date.today + i.days) }
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assings all talks as @talks ordered by deadline" do
      get :index
      expect(assigns(:talks)).to eq(talks)
    end

    context "when ordering by score" do
      let(:talks) do
        3.times.map { |i| create(:talk, cached_votes_score: i) }
      end

      it "assigns the talks with the correct ordering" do
        get :index, sort_by: :score
        expect(assigns(:talks)).to eq(talks.reverse)
      end
    end
  end

  describe "GET #show" do
    let(:talk) { FactoryGirl.create(:talk) }

    it "assings the requested talk as @talk" do
      get :show, { id: talk.slug }
      expect(assigns(:talk)).to eq(talk)
    end

    it "renders the show template" do
      get :show, { id: talk.slug }
      expect(response).to render_template(:show)
    end
  end

end
