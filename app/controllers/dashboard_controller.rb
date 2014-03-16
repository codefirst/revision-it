class DashboardController < ApplicationController
  def index
    @revisions = Revision.all.limit(4)
  end
end
