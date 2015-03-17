class Document < ActiveRecord::Base

  belongs_to  :user

  validates_presence_of :title, :description, :pdf

  has_attached_file :pdf
  validates_attachment_content_type :pdf, content_type: 'application/pdf'
end
