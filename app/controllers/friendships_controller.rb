class FriendshipsController < ApplicationController
	def create
		@friendships = current_user.friendships.create(:friend_id => params[:friend_id])
		if @friendships.save
			flash[:notice] = "Added friend."
			redirect_to :back
		else 
			flash[:error] = "not created"
			redirect_to :back
		end
	end
end
