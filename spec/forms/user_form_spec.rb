require 'spec_helper'

describe UserForm do
  let(:params) { attributes_for(:user) }
  subject { described_class.new(params) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:avatar_url) }
  it { should validate_presence_of(:github_uid) }

  it "returns right username" do
    expect(subject.username).to eq(params[:username])
  end

  describe "#submit" do
    context "when uniqueness validation" do
      shared_examples_for "an invalid form" do |field|
        it "returns false" do
          expect(subject.submit).to be false
        end

        it "does not invoke User#save" do
          expect_any_instance_of(User).to_not receive(:save)
          subject.submit
        end

        it "adds taken error to #{field}" do
          subject.submit
          expect(subject.errors[field]).to include(I18n.t('errors.messages.taken'))
        end
      end

      context "when duplicated e-mail" do
        before { create(:user, email: params[:email]) }

        it_behaves_like "an invalid form", :email
      end

      context "when duplicated user name" do
        before { create(:user, username: params[:username]) }

        it_behaves_like "an invalid form", :username
      end

      # context "when duplicated Github UID" do
      #   before { create(:user, github_uid: params[:github_uid]) }

      #   it_behaves_like "an invalid form", :github_uid
      # end
    end

    context "when there are valid params" do
      it "returns true" do
        expect(subject.submit).to be true
      end

      it "invokes User#save" do
        expect(subject.record).to receive(:save)
        subject.submit
      end

      context "when the user already exists" do
        let!(:user) { create(:user, github_uid: params[:github_uid]) }

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
