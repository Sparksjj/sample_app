class SessionsController < ApplicationController
	def new
		
	end

	def create
		user=User.find_by(email: params[:sesseon][:email].downspase)
		#if user && user.authenticate(params[:sesseon][:pasword])
		#	sign_in user
		#	redirect_to user
		#else
		#	flash.now[:error]="Invalid email/password combination."
			render "new"
#
		#end
	end

	def destroy
		
	end
end
