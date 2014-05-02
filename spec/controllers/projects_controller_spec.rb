require 'spec_helper'

describe ProjectsController do
  let(:project) { create(:project) }
  let(:user)    { create(:user)    }

  context "not sign-in" do
    describe "GET 'index'" do
      before { get 'show' }
      subject { response }
      it { should redirect_to(new_user_session_path) }
    end
  end

  context "sign-in" do
    before { sign_in user }


    describe "GET 'index'" do
      before { get 'show', id: project.id }

      describe 'response' do
        subject { response }
        it { should be_success }
      end

      describe 'assigned project' do
        subject { assigns[:project] }
        its(:id) { should == project.id }
      end
    end
  end
end
