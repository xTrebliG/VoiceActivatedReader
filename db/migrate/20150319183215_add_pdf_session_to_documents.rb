class AddPdfSessionToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :pdf_session, :string
  end
end
