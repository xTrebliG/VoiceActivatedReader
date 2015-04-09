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
    @document.cover_file_name

    respond_to do |f|

      sleep(1.0)
      if @document.cover_file_name.blank?
        if @document.save
          f.html{
            redirect_to user_path(@document.user_id)
            flash[:notice] = 'New Document Uploaded!'
          }
        else
          f.html{
            redirect_to :back
            flash[:notice] = 'Document Failed To Upload!' }
          f.js
        end
      else
        p 'test'
        @document.pdf_from_url = @document.cover_file_name
        if @document.save
          f.html{
            redirect_to user_path(@document.user_id)
            flash[:notice] = 'New Document Uploaded!'
          }
        else
          f.html{
            redirect_to :back
            flash[:notice] = 'Document Failed To Upload!' }
          f.js
        end
      end

    end


  end

  def update
    respond_to do |f|
      @document = Document.find params[:id]
      if @document.update_attributes(doc_title_params)
        f.html{redirect_to current_user, notice: 'Document Updated Successfully!'}
        f.json{respond_with_bip(@document)}
      else
        f.html { render :action => "edit" }
        f.json{respond_with(@document)}
      end
    end


  end

  def show
    if Document.exists?(params[:id])
     if current_document.user_id == current_user.id
       pdf_session_check
     else
       redirect_to current_user
       flash[:notice] = 'Oops! You Dont Have Access To That!'
     end
    else
      redirect_to current_user
      flash[:notice] = 'Oops! Something went wrong!'
    end



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
    params.require(:document).permit(:title, :description, :pdf, :pdf_file_path, :cover, :cover_file_name).merge(user_id: current_user.id)
  end

  def doc_title_params
    params.require(:document).permit(:title)
  end


end
