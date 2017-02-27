class FriendshipsController < ApplicationController
# the '<' symbol means subclass

	before_action :authenticate_user!
	# we do this because we only want signed in users 
	# be able to do this
	def create # define the create action
		friend = User.find(params[:friend_id])
		Friendship.create(friendship_params.merge!(friend_id: params[:friend_id], 
			user_id: current_user.id)) unless current_user.follows_or_same?(friend)
		redirect_to root_path
		# we don't want the user to follow someone they already follow
		# or themselves

	end

	def friendship_params
		params.permit(:friend_id, :user_id)
	end
end