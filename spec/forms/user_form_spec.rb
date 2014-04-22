require 'spec_helper'

describe UserForm do
  let(:params) do
    { username: "filipewl",
      email: "fwl.ufpe@gmail.com",
      name: "Filipe W. Lima",
      avatar_url: "https://avatars.githubusercontent.com/u/381395?"
    }
  end
  subject { described_class.new(params) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:avatar_url) }

  it "returns right username" do
    expect(subject.record.username).to eq(params[:username])
  end

  describe "#submit" do
    context "when there are valid params" do
      it "returns true" do
        expect(subject.submit).to be true
      end

      it "invokes User#save" do
        expect(subject.record).to receive(:save)
        subject.submit
      end

      context "when the user already exists" do
        let!(:user) { create(:user, email: params[:email]) }

        it "initialize the user" do
          subject.submit
          expect(subject.record).to eq(user)
        end
      end
    end

    context "when there are invalid params" do
      let(:params) { {} }
      it "returns false" do
        expect(subject.submit).to be false
      end

      it "error should not be empty" do
        subject.submit
        expect(subject.errors).to_not be_empty
      end
    end
  end
end
