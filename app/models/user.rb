class User < ActiveRecord::Base
  has_many :documents, dependent: :destroy

  validates_uniqueness_of :email
  validates_presence_of :email, :password, :name

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>'}, default_url: '/images/:style/missing.png',
                    :storage => :s3,
                    :s3_credentials => {
                        :bucket => ENV['BUCKET_NAME'],
                        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                        path: ':class/:attachment/:id/:filename'}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


end
