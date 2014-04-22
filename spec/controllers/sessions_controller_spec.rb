require 'spec_helper'

describe SessionsController do
  context "when posting to SessionsController#create" do
    let(:email) { 'fwl@cin.ufpe.br' }
    let(:info) do
      double('user information', name: 'Filipe', nickname: 'fwl', email: email)
    end
    it "creates an user" do
      allow(controller).to receive(:info).and_return(info)
      # env['bla'] => def [](bla)
      expect { post :create }.to change(User, :count)
    end
  end

  describe "#destroy" do
    it "clears the user from the session"
  end
end
