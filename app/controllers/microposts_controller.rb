class MicropostsController < ApplicationController
  before_action :signed_in_user

  def create
  	@micropost=current_user.microposts.build(micropost_param)
  	if @micropost.seve
  		flash[:success]="Microposts created!"
  		redirect_to root_url
  	else
  		render 'static_pages/home'
  	end
  end

  def destroy
  end

private

	def micropost_param
		params.require(:micropost).permit(:content)		
	end

end