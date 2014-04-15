require 'spec_helper'

describe WelcomeController do
  context "not sign in" do
    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_success
      end
    end
  end

  context "user sign in" do
    describe "GET 'index'" do
      before do
        user = User.create!
        user.save
        sign_in user
      end

      it "returns http success" do
        get 'index'
        response.should redirect_to(dashboard_path)
      end
    end
  end
end
