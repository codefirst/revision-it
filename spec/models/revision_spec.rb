require 'spec_helper'

describe Revision do
  before { @revision = create(:revision) }

  describe 'from hash' do
    subject { Revision.from_hash @revision.hash_code[0,3] }
    it { should == @revision }
  end
end
