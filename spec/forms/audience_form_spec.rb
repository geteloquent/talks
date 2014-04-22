require "spec_helper"

describe AudienceForm do
  subject { described_class.new(attributes) }
  let(:attributes) { attributes_for(:audience) }

  it { should validate_presence_of(:name) }

  describe "#submit" do
    it "invokes Audience#save" do
      expect_any_instance_of(Audience).to receive(:save)
      subject.submit
    end

    it "returns true" do
      expect(subject.submit).to be true
    end

    context "with invalid params" do
      before { attributes.merge!(name: nil) }

      it "returns false" do
        expect(subject.submit).to be false
      end

      it "does not invoke Audience#save" do
        expect_any_instance_of(Audience).not_to receive(:save)
        subject.submit
      end

      context "with duplicated names" do
        let(:duplicated_name) { Faker::Lorem.word }
        before do
          attributes.merge!(name: duplicated_name)
          create(:audience, name: duplicated_name)
        end

        it "cannot be saved" do
          subject.submit
          expect(subject.errors[:name]).to include(I18n.t('errors.messages.taken'))
        end
      end
    end
  end
end
