class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @user = User.new
    @document = Document.new


  end

  def new
    @user = User.new
    respond_to do |f|
      f.html
      f.js
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
          session[:user_id] = @user.id
          redirect_to root_path
          flash[:notice] = 'Thanks For Signing Up!'
    else
      if @user.errors.any?
        flash[:notice] = @user.errors.full_messages
      end
          # flash[:alert] = "Whoops That Didn't Work!"
          redirect_to root_path
      end
  end

  def show

  if User.exists?(params[:id])
    @user = User.find(params[:id])
    p get_id = User.find(params[:id])
    p check_library = get_id[:id]
   if params[:id] != "#{current_user.id}"
     redirect_to current_user
   end
  else
    redirect_to current_user
  end

  end

  def update

    respond_to do |format|
      format.html { if @user.update(user_params)
                      flash[:notice]= 'Update Successful!'
                      redirect_to @user
                    else
                      flash[:notice]= "Looks like you don't have permission to do that!"
                    end
                  }
      format.js
    end

    # if current_user.id == params[:id]
    #
    # else
    #   flash[:notice]= "Whoops! You are unable to edit that user!"
    #   render :show
    # end

  end

  def destroy
    current_user.destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def current_user
    session[:user_id] ? User.find(session[:user_id]) :nil
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar)
  end

  def set_user
    @user = User.find(params[:id])

  end


end
