class DocumentsController < ApplicationController
  include DocumentsHelper
  require "webrick/https"
  skip_before_filter  :verify_authenticity_token

  def index
    if current_user
      redirect_to users_path
    end

  end

  def new

    @document = Document.new



  end

  def create
    @document = Document.new(doc_params)
    @document.user_id = current_user.id
    @document.pdf_file_path = params[:path]
    respond_to do |f|

      sleep(1.0)
      if @document.save
        f.html{
          redirect_to user_path(@document.user_id)
          flash[:notice] = 'New Document Uploaded!'
        }
      else
        f.html{
          redirect_to :back
          flash[:alert] = 'Document Failed To Upload!' }
        f.js
      end

    end


  end

  def update


  end

  def show
    pdf_session_check

  end

  def destroy
    @doc_id = "#document_#{current_document.id}"
    p @doc_id

    respond_to do |f|
      f.js {
      }
    end

    current_document.destroy

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
