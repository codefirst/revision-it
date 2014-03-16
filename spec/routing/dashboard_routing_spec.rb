require "spec_helper"

describe DashboardController do
  describe "routing" do

    it "routes to #index via GET" do
      get("/dashboard").should route_to("dashboard#index")
    end

    it "routes to #index via POST" do
      # This is temporaly routing.
      # After implementing login, please delete this.
      post("/dashboard").should route_to("dashboard#index")
    end
  end
end
