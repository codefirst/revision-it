class DashboardController < ApplicationController
  def index
    @revisions = Revision.order(date: :desc).limit(4)
  end
end
