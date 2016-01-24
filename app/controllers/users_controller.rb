class UsersController < ApplicationController
  before_action :protect_unsign_users, only: [:show, :edit, :update, :create, :index]
  def index
  	@users=User.all
  end

  def show
  	@user=User.find(params[:id])
  end

  def new
  	@user=User.new
  end

  def create
  	@user=User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success]="Welcome a board!"
  		redirect_to @user
  	else
  		render 'new'
  	end  	
  end

  def edit
    @user=User.find(params[:id]) 
  end

  def update
    @user=User.find(params[:id])  
    if @user.update_attributes(user_params)
      flash[:success]="Update has been saved"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end


private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def protect_unsign_users     
    unless signed_in?
        flash[:error]="Pleas sign in or sign up."
        redirect_to signin_path 
    end
  end
end
