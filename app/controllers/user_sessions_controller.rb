class UserSessionsController < ApplicationController
	skip_before_filter :require_login, except: [:destroy]
	def new
		@user = User.new
	end
	def create
		if @user = login(params[:email], params[:password])
			redirect_back_or_to(posts_path, message: "Login sucessful")
		else
			flash.now[:alert] = "Something is wrong with the login"
		end
	end
	def destroy
		logout
		redirect_to(:users, message: "Logged out")
	end
end