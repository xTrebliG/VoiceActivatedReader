module ApplicationHelper
  def current_user
    session[:user_id] ? User.find(session[:user_id]) :nil
  end

  def current_document
    Document.find(params[:user_id, :id])
  end
end
