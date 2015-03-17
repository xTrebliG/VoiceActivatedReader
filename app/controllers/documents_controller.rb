class DocumentsController < ApplicationController

  def index

  end

  def new
    @document = Document.new

  end

  def create
    @document = Document.new(doc_params)
    @document.user_id = current_user.id
    if @document.save
      redirect_to current_user
      flash[:notice] = 'New Document Uploaded!'
    else
      redirect_to :back
      flash[:alert] = 'Document Failed To Upload!'
    end

  end

  def update

  end

  def show

  end

  def destroy

  end

  private

  def current_user
    session[:user_id] ? User.find(session[:user_id]) :nil
  end

  def doc_params
    params.require(:document).permit(:title, :description, :pdf_url).merge(user_id: current_user.id)
  end

end
