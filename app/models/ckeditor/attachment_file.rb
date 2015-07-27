class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
    				:storage => :s3,
  					:s3_credentials => S3_CREDENTIALS,
            :s3_host_name => 's3-ap-southeast-1.amazonaws.com',
            :url => "/ckeditor_assets/attachments/:id/:filename",
            :path => "/ckeditor_assets/attachments/:id/:filename"

  validates_attachment_size :data, :less_than => 100.megabytes
  validates_attachment_presence :data

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
