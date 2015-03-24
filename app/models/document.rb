class Document < ActiveRecord::Base

  belongs_to  :user

  validates_presence_of :title

  has_attached_file :pdf, :styles => { cover: ['150x250>', :jpg] },
                    :storage => :s3,
                    :s3_credentials => {
                        :bucket => ENV['BUCKET_NAME'],
                        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                    path: ':class/:attachment/:id/:filename'}

  has_attached_file :cover

  validates_attachment_content_type :pdf, content_type: 'application/pdf'
  validates_attachment_presence :pdf


end
