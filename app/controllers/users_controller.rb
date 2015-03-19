class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

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
      redirect_to root_path
      flash[:alert] = "Whoops That Didn't Work!"
    end

  end

  def show

  end

  def update

    respond_to do |format|
      format.html { if @user.update(user_params)
                      flash[:notice]= 'Update Successful!'
                      redirect_to @user
                    else
                      flash[:alert]= "Looks like you don't have permission to do that!"
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
