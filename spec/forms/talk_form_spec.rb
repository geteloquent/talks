require 'spec_helper'

describe TalkForm do
  let(:attributes) do
    attributes_for(:talk). \
      merge(nested_audiences_attributes: nested_audiences_attributes)
  end
  let(:nested_audiences_attributes) { { "0" => attributes_for(:audience) } }
  subject { described_class.new(attributes) }

  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_least(3) }

  it { should validate_presence_of(:slug) }
  it { should ensure_length_of(:slug).is_at_least(3) }

  it { should validate_presence_of(:description) }

  it { should validate_presence_of(:deadline) }
  it { should_not allow_value(Date.yesterday).for(:deadline) }

  shared_examples_for "an invalid form" do
    it "returns false" do
      expect(subject.submit).to be_false
    end
  end

  context "uniqueness validation" do
    let(:duplicated_slug) { Faker::Internet.slug }
    before do
     subject.slug = duplicated_slug
     create(:talk, slug: duplicated_slug)
    end

    it_behaves_like "an invalid form"

    it "does not invoke Talk#save" do
      expect_any_instance_of(Talk).to_not receive(:save)
      subject.submit
    end

    it "adds taken error to slug" do
      subject.submit
      expect(subject.errors[:slug]).to_not be_empty
    end
  end

  describe "#submit" do
    it "invokes Talk#save" do
      expect_any_instance_of(Talk).to receive(:save)
      subject.submit
    end

    it "invokes Audience#save" do
      expect_any_instance_of(Audience).to receive(:save).at_least(:once)
      subject.submit
    end

    it "returns true" do
      expect(subject.submit).to be_true
    end

    context "with invalid params" do
      context "when a talk attribute is invalid" do
        let(:attributes) { attributes_for(:talk, title: nil) }

        it "does not invoke Talk#save" do
          expect_any_instance_of(Talk).to_not receive(:save)
          subject.submit
        end
      end

      context "when no audience is selected" do
        let(:attributes) { attributes_for(:talk) }
        it_behaves_like "an invalid form"
      end

      context "when a duplicated audience is used" do
        let(:duplicated_audience_name) { "Alunos" }
        let(:nested_audiences_attributes) do
          { "0" => attributes_for(:audience, name: duplicated_audience_name) }
        end
        before { create(:audience, name: duplicated_audience_name) }

        it_behaves_like "an invalid form"
      end

      context "when a duplicated reference is used" do
        let(:duplicated_reference_url) { Faker::Internet.url }
        let(:references_attributes) do
          { "0" => attributes_for(:reference, url: duplicated_reference_url),
            "1" => attributes_for(:reference, url: duplicated_reference_url) }
        end
        before { attributes.merge!(references_attributes: references_attributes) }

        it_behaves_like "an invalid form"
      end
    end
  end

  describe "#build_reference" do
    it "should build an empty reference" do
      subject.build_reference
      expect(subject.references.last.record).to be_a_new_record
    end
  end

  describe "#references_attributes=" do
    let(:references_attributes) do
      { "0" => attributes_for(:reference).merge!(_destroy: "false"),
        "1" => attributes_for(:reference).merge!(_destroy: "false"),
        "2" => attributes_for(:reference).merge!(_destroy: "1"),
        "3" => attributes_for(:reference, url: nil).merge!(_destroy: "false") }
    end
    before { attributes.merge!(references_attributes: references_attributes) }

    it "should remove from the params the URLs that are blank" do
      expect(subject.references.size).to be 2
    end

    it "should remove from the params the URLs that are marked to be destroyed" do
      expect(subject.references.size).to be 2
    end
  end

  describe "#nested_audiences_attributes=" do
    let(:nested_audiences_attributes) do
      { "0" => attributes_for(:audience).merge!(_destroy: "false"),
        "1" => attributes_for(:audience).merge!(_destroy: "false"),
        "2" => attributes_for(:audience).merge!(_destroy: "1"),
        "3" => attributes_for(:audience, name: nil).merge!(_destroy: "false") }
    end
    before { attributes.merge!(nested_audiences_attributes: nested_audiences_attributes) }

    it "should remove from the params the names that are blank" do
      expect(subject.audiences.size).to be 2
    end

    it "should remove from the params the names that are marked to be destroyed" do
      expect(subject.audiences.size).to be 2
    end
  end

  context "associated audiences and nested ones" do
    let(:audience) { create(:audience) }
    let(:attributes) do
      attributes_for(:talk).merge(audience_ids: [audience.id], \
        nested_audiences_attributes: nested_audiences_attributes)
    end

    describe "#nested_audiences" do
      it "returns only audiences that are not saved" do
        expect(subject.nested_audiences).to have(1).items
      end
    end

    describe "#audiences" do
      it "returns both associated audiences and nested ones" do
        expect(subject.audiences).to have(2).items
      end
    end
  end
end
