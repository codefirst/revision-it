class DashboardController < ApplicationController
 def index
   @projects  = current_user.projects
   @revisions = Revision.limit(4)
  end
end
