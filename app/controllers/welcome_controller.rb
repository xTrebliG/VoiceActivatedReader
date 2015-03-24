class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to users_path
    end
  end

  private

  def current_user
    session[:user_id] ? User.find(session[:user_id]) :nil
  end
end