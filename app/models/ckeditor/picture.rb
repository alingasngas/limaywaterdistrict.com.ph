class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
      				:storage => :s3,
  					  :s3_credentials => S3_CREDENTIALS,
              :s3_host_name => 's3-ap-southeast-1.amazonaws.com',
              :url  => "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
              :path => "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
              :styles => { :content => '800>', :thumb => '118x100#' }

  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end
end
