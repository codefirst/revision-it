require 'spec_helper'

describe User do
  let(:project) { create(:project) }
  let(:user)    { create(:user)    }

  describe "project" do
    subject { user.projects }

    context "duplicate project" do
      before { 3.times {
        user.projects << project
      } }
      it { should have(1).item }
    end

    context "multiple project" do
      before do
        user.projects << create(:project, repos: "a")
        user.projects << create(:project, repos: "b")
      end
      it { should have(2).item }
    end
  end
end
