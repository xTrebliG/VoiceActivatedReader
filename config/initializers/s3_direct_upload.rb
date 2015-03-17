S3DirectUpload.config do |c|
  c.access_key_id = "AKIAJIPO6NOF6CZGU6WA"       # your access key id
  c.secret_access_key = "OrmCYMJ4FXH+ohGnXyLxgzeS4oRyalqxmWpQ2Kc2"   # your secret access key
  c.bucket = "voicepdf"              # your bucket name
  c.url = "https://#{c.bucket}.s3.amazonaws.com/"
end

