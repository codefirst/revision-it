require 'spec_helper'

describe Project do
  let(:project) { create(:project) }
  let(:user)    { create(:user)    }

  describe "user" do
    subject { project.users }

    context "duplicate user" do
      before { 3.times {
        project.users << user
      } }
      it { should have(1).item }
    end

    context "multiple project" do
      before do
        project.users << create(:user, name: "mzp")
        project.users << create(:user, name: "nzp")
      end
      it { should have(2).item }
    end
  end

  describe "display name" do
    subject { project }
    its(:display_name) { should == "codefirst/revision-it" }
  end
end
