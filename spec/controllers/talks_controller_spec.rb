require "spec_helper"

describe TalksController do

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
