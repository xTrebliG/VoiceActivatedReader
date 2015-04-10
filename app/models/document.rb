class Document < ActiveRecord::Base
  require 'open-uri'
  belongs_to  :user

  validates_presence_of :title, message: 'Must Add A Title'


  has_attached_file :pdf, :styles => { cover: ['150x250>', :png]},
                    :convert_options => {
                        :cover => '-background white',
                    },
                    :storage => :s3,
                    :s3_credentials => {
                        :bucket => ENV['S3_BUCKET_NAME'],
                        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                    path: ':class/:attachment/:id/:filename'}
  has_attached_file :cover

  validates_attachment_content_type :pdf, content_type: 'application/pdf'
  validates_attachment_presence :pdf, :if => 'cover_file_name.blank?', message: 'Must add a file'



  def pdf_from_url=url
    self.pdf = open(url)
  end






end
