class DocumentsController < ApplicationController
  include DocumentsHelper

  def index

  end

  def new

    @document = Document.new

  end

  def create
    @document = Document.new(doc_params)
    @document.user_id = current_user.id
    @document.pdf_file_path = params[:path]

    if @document.save

      redirect_to current_user
      flash[:notice] = 'New Document Uploaded!'
    else
      redirect_to :back
      flash[:alert] = 'Document Failed To Upload!'

      if @document.errors.any?
         puts @document.errors.full_messages
      end

    end

  end

  def update


  end

  def show
    pdf_session_check

  end

  def destroy
    current_document.destroy
    redirect_to current_user

  end

  private

  def current_document
    Document.find(params[:id])
  end

  def current_user
    session[:user_id] ? User.find(session[:user_id]) :nil
  end

  def doc_params
    params.require(:document).permit(:title, :description, :pdf, :pdf_file_path, :cover).merge(user_id: current_user.id)
  end

end
