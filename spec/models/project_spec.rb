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

  describe "revisions" do
    let(:rev_a) { create(:revision, id: 1, hash_code: 'aaaa', date: Date.new(2000,1,1)) }
    let(:rev_b) { create(:revision, id: 2, hash_code: 'bbbb', date: Date.new(2000,2,1)) }
    let(:rev_c) { create(:revision, id: 3, hash_code: 'cccc', date: Date.new(2000,3,1)) }

    describe "sort order" do
      before {
        [rev_c, rev_a, rev_b ].each {|r| project.revisions << r }
      }
      subject { project.revisions }
      it { should == [ rev_c, rev_b, rev_a ] }
    end
  end

  describe "display name" do
    subject { project }
    its(:display_name) { should == "codefirst/revision-it" }
  end
end
