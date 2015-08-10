class SessionsController < ApplicationController

	def new

	end

	def create

	@user = User.authenticate(params[:username], params[:password])

	if @user

		flash[:success] = @user.username + " let's get some stuff done!"

		session[:user_id] = @user.id

		redirect_to '/'

	else

		flash[:alert] = '<strong>You Fail At Logging In</strong> <p>Your username or password was incorrect</p>'

		redirect_to '/'

	end

	end

	def destroy

	session[:user_id] = nil

	flash[:notice] = 'Logged out already? Guess you must have finished your work!'

	redirect_to '/'

	end

end
