class DocumentsController < ApplicationController

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
    start_pdf_viewer
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
    params.require(:document).permit(:title, :description, :pdf, :pdf_file_path).merge(user_id: current_user.id)
  end

  def start_pdf_viewer

      response = `curl https://view-api.box.com/1/documents\ -H "Authorization: Token 7zzv7ix86tsj1np4n8rjp60zpda2mf5d"\
              -H "Content-Type: application/json"\
              -d '{"url": "#{current_document.pdf.url}"}' \
              -X POST `

      parsed_response = JSON.parse(response)
      doc_id =  parsed_response['id']

      sleep(2.0)

      response2 = `curl https://view-api.box.com/1/sessions \ -H 'Authorization: Token 7zzv7ix86tsj1np4n8rjp60zpda2mf5d'\
              -H "Content-Type: application/json"\ -d '{"document_id": "#{doc_id}", "duration": 60}' \
              -X POST \
              -i`

      r = response2

      final_response = JSON.parse(r.split("\n").last)
      @pdf_session_id = final_response['id']

      @document_url = "https://view-api.box.com/1/sessions/#{@pdf_session_id}/assets/"

      # /view?theme=dark




  end

end
