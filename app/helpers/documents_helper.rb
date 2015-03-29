module DocumentsHelper
  def start_pdf_viewer
    response = `curl https://view-api.box.com/1/documents\ -H "Authorization: Token 7zzv7ix86tsj1np4n8rjp60zpda2mf5d"\
              -H "Content-Type: application/json"\
              -d '{"url": "#{current_document.pdf.url}"}' \
              -X POST `
    parsed_response = JSON.parse(response)
    @doc_id =  parsed_response['id']
    @doc_status = parsed_response['status']

  p "DOCUMENT STATUS = " + @doc_status
    p parsed_response
    if @doc_status == 'queued'
      def create_sess
        sleep(1.0)
        @z_response = `curl https://view-api.box.com/1/sessions \ -H 'Authorization: Token 7zzv7ix86tsj1np4n8rjp60zpda2mf5d'\
                -H "Content-Type: application/json"\ -d '{"document_id": "#{@doc_id}", "duration": 525949}' \
                -X POST \
                -i`
        @check_response2 = @z_response.split("\r").first

        p @z_response

        if @check_response2 == 'HTTP/1.1 201 CREATED'
          @check_response3 = JSON.parse(@z_response.split("\n").last)
          @pdf_session_id = @check_response3['id']
          @document_url = "https://view-api.box.com/1/sessions/#{@pdf_session_id}/assets/"
          @document_real_time = @check_response3['urls']['realtime']
          @current = current_document
          @current.pdf_session = @document_url
          @current.pdf_file_path = @document_real_time
          @current.save!
          flash[:notice] = 'Document Loaded!'
        elsif @check_response2 == 'HTTP/1.1 202 ACCEPTED'
          create_sess

        else
          p @z_response
        end
      end
    end
    create_sess
  end
  def pdf_session_check
    @pdf_response = `curl -IL #{current_document.pdf_file_path}`
    p pdf_response_check = @pdf_response.split("\r").first

    if pdf_response_check == 'HTTP/1.1 404 NOT FOUND' || pdf_response_check == nil
      start_pdf_viewer
    end
  end
end
