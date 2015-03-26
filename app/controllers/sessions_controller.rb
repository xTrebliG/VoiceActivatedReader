class SessionsController < ApplicationController


  def create
    @user = User.find_by(email: params[:email])
    if @user and @user.password == params[:password]
      flash[:notice] = "Successfully signed in!"
      session[:user_id] = @user.id
      redirect_to users_path
    else
      flash[:notice] = "Something went wrong."
      redirect_to root_path
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

end
