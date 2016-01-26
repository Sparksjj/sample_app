class SessionsController < ApplicationController
	before_action :require_login, only: :destroy
	def new
		
	end

	def create
		user=User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
		else
			flash.now[:error]="Invalid email/password combination."
			render "new"

		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

	private

	def require_login
		unless signed_in?
			flash[:error]="You must be logged in to access this function"
			redirect_to signin_path
		end
	end
end
