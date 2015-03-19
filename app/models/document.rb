class Document < ActiveRecord::Base

  belongs_to  :user

  validates_presence_of :title, :description

  has_attached_file :pdf, :styles => { cover: ['200x300>', :jpg] },
                    storage: :dropbox,
                    dropbox_credentials: Rails.root.join('config/dropbox.yml'),
                    dropbox_visibility: 'public',
                    path: ':class/:attachment/:id/:filename'

  has_attached_file :cover

  validates_attachment_content_type :pdf, content_type: 'application/pdf'


end
