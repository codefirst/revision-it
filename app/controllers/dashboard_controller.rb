class DashboardController < ApplicationController
 def index
   @projects  = current_user.projects
   @revisions = Revision.order(date: :desc).limit(4)
  end
end
