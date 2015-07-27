class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      
      t.string            :title
      t.string            :caption
      t.string            :url
      t.string            :banner_file_name
      t.string            :banner_content_type
      t.integer           :banner_file_size
      t.boolean           :featured
      t.integer           :page_id
      t.boolean           :activate
      t.integer           :last_updated_by
      
      t.timestamps
      
    end
  end
  
  def self.down
    drop_table    :banners
  end
end
