require "spec_helper"

describe ProjectsController do
  describe "routing" do
    it "routes to #show" do
      get("/project/4728").should route_to("projects#show", id: "4728")
    end
  end
end
