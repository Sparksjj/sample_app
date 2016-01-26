class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]
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
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success]="Update has been saved"
      redirect_to @user
    else
      render 'edit'
    end
  end


private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def require_login  
    unless signed_in?
        store_location
        flash[:error]="Pleass sign in or sign up first."
        redirect_to signin_path 
    end
  end

  def correct_user
    @user=User.find(params[:id])
    unless correct_user?(@user)
      flash[:error]="Maybe you meant thise page" 
      redirect_to edit_user_path(current_user)
    end
  end

end
