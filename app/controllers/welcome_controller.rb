class WelcomeController < ApplicationController
  def index
    respond_to do |f|
      f.html{
          if current_user
            redirect_to users_path
          end
      }
      f.js

    end
  end

  def parallax
    @user = User.new
      render :layout => false
          if current_user
            # redirect_to users_path
          end
  end

  private

  def current_user
    session[:user_id] ? User.find(session[:user_id]) :nil
  end
end