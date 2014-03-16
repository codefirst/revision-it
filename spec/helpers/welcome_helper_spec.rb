require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the WelcomeHelper. For example:
#
# describe WelcomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ApplicationHelper do
  describe "#link_to_revision" do
    subject { link_to_revision "foo" }
    it { should == %(<a href="/revisions/foo">foo</a>) }
  end

  describe "#link_to_url" do
    subject { link_to_url "http://example.com" }
    it { should == %(<a href="http://example.com">http://example.com</a>) }
  end
end
