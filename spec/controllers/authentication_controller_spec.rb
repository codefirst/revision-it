require 'spec_helper'

describe AuthenticationController do
  describe "get 'login'" do
    before { get 'login' }
    subject { response }
    it { should redirect_to(root_path) }
  end

  describe "get 'logout'" do
    before do
      user = User.create!
      user.save
      sign_in user
    end

    describe 'response' do
      before { get 'logout' }
      subject { response }
      it { should redirect_to(root_path) }
    end

    describe 'session' do
      before { get 'logout' }
      subject { controller.current_user }
      it { should be_nil }
    end
  end

  describe 'github' do
    context "already logined" do
      before do
        @user = User.create!(name: "mzp")
        @user.save
        sign_in @user
      end

      before {
        controller.request.env['omniauth.auth'] = { 'info' => { 'nickname' => 'mzp' } }
        get 'github'
      }
      it { response.should redirect_to(dashboard_path) }
      it { controller.current_user.should == @user }
    end

    context "new user" do
      before {
        controller.request.env['omniauth.auth'] = { 'info' => { 'nickname' => 'mzp' } }
        get 'github'
      }
      it { response.should redirect_to(dashboard_path) }
      it { controller.current_user.name.should == 'mzp' }
    end

    context "exist user" do
      before do
        @user = User.create!(name: "mzp")
        @user.save
      end

      before {
        controller.request.env['omniauth.auth'] = { 'info' => { 'nickname' => 'mzp' } }
        get 'github'
      }
      it { response.should redirect_to(dashboard_path) }
      it { controller.current_user.should == @user }
    end


    context 'invalid payload' do
      context "no payload" do
        before {
          controller.request.env['omniauth.auth'] = {}
          get 'github'
        }
        subject { response }
        it { should_not be_success }
        its(:status) { should == 400 }
      end

      context "unknown structure" do
        before {
          controller.request.env['omniauth.auth'] = { 'info' => {} }
          get 'github'
        }
        subject { response }
        it { should_not be_success }
        its(:status) { should == 400 }
      end
    end
  end

  describe "describe 'failure'" do
    before { get 'failure' }
    subject { response }
    it { should redirect_to(root_path) }
  end
end
