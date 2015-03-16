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

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
