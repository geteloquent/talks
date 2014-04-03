require "spec_helper"

describe ReferenceForm do
  subject { described_class.new(attributes) }
  let(:attributes) { attributes_for(:reference) }

  it { should validate_presence_of(:url) }
  # it { should validate_uniqueness_of(:url).scoped_to(:talk_id).case_insensitive }
  it { should allow_value('http://www.google.com', 'http://bar.com/foo').for(:url) }
  it { should_not allow_value('dfsfgd').for(:url) }

  describe "#submit" do
    it "invokes Reference#save" do
      expect_any_instance_of(Reference).to receive(:save)
      subject.submit
    end

    it "returns true" do
      expect(subject.submit).to be_true
    end

    context "with invalid params" do
      before { attributes.merge!(url: "invalido") }

      it "returns false" do
        expect(subject.submit).to be_false
      end

      it "does not invoke Reference#save" do
        expect_any_instance_of(Reference).not_to receive(:save)
        subject.submit
      end

      context "when duplicated inside a talk" do
        let(:talk) { create(:talk) }
        let(:duplicated_url) { Faker::Internet.url }
        before do
          create(:reference, url: duplicated_url, talk_id: talk.id)
          attributes.merge!(url: duplicated_url, talk_id: talk.id)
        end

        it "cannot save a duplicated reference scoped to the same talk" do
          subject.submit
          expect(subject.errors[:url]).not_to be_empty
        end
      end
    end
  end
end
