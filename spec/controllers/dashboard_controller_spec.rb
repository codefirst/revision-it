require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    before do
      @foo = create(:revision, hash_code: 'foo')
      @bar = create(:revision, hash_code: 'bar')
      @baz = create(:revision, hash_code: 'baz')
      get 'index'
    end

    describe 'response' do
      subject { response }
      it { should be_success }
    end

    describe 'revisions' do
      subject { assigns(:revisions) }

      it { should_not be_empty }
      it { should include(@foo,@bar,@baz) }
    end
  end
end
