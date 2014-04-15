class DashboardController < ApplicationController
 def index
   p current_user
   @revisions = Revision.order(date: :desc).limit(4)
  end
end
