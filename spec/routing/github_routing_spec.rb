require "spec_helper"

describe GithubController do
  describe "routing" do
    it "routes to #index" do
      get("/github").should route_to("github#index")
    end

    it "routes to #hook" do
      post("/github/hook").should route_to("github#hook")
    end

    it "routes to #import_all" do
      post("/github/import_all").should route_to("github#import_all")
    end
  end
end
