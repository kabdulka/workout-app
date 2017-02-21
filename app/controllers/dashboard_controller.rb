class DashboardController < ApplicationController
  def index
  	## this basically picks up all users
  	##@athletes = User.all
  	@athletes = User.paginate(:page => params[:page])
  end
end
