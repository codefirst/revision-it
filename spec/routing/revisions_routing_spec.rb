require "spec_helper"

describe RevisionsController do
  describe "routing" do

    it "routes to #index" do
      get("/revisions").should route_to("revisions#index")
    end

  end
end
