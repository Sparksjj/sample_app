class UsersController < ApplicationController
  before_action :have_signed_in, only: [:new, :create]
  before_action :require_login, only: [:show, :edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :is_admin, only: [:destroy]
  def index
  	@users=User.paginate(page: params[:page], per_page: "10")
  end

  def show
  	@user=User.find(params[:id])
    @microposts=@user.microposts.paginate(page: params[:page], per_page: "15")
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  
  def have_signed_in  
    if signed_in?
        flash[:error]="You have signed in yet."
        redirect_to root_path
    end
  end

  def correct_user
    @user=User.find(params[:id])
    unless correct_user?(@user)
      flash[:error]="Maybe you meant thise page" 
      redirect_to edit_user_path(current_user)
    end
  end
  def is_admin
    unless current_user.admin?
      flash[:error]="You mast be admin"
      redirect_to users_url 
    end    
  end

end
