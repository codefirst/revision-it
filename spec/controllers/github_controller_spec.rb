require 'spec_helper'

describe GithubController do
  describe "GET 'index'" do
    before do
      get 'index'
    end

    describe 'response' do
      subject { response }
      it { should be_success }
    end
  end
end

