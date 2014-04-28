require 'spec_helper'
require 'cancan/matchers'

describe User do
  it { should respond_to(:likes) }
  it { should respond_to(:dislikes) }

  it { should have_many :talks }

  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    let(:user) { create(:user) }

    it { should be_able_to(:create, Talk.new) }

    context "when there's no user" do
      let(:user) { nil }

      it { should_not be_able_to(:create, Talk.new) }
    end
  end
end
