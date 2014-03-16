require "spec_helper"

describe RevisionsController do
  describe "routing" do
    it "routes to #index" do
      get("/revisions").should route_to("revisions#index")
    end

    it "routes to #show" do
      get("/revisions/foo").should route_to("revisions#show", hash: 'foo')
    end

    it "routes to #via_hash" do
      get("/hash/foo").should route_to("revisions#via_hash", hash: 'foo')
    end
  end
end
