class AddPageTypeToPages < ActiveRecord::Migration
  def self.up
    add_column      :pages,         :page_type,   :string,        default: 'page'
    add_column      :pages,         :published_by,      :string
    add_column      :pages,         :is_featured,     :boolean,       default: false
    add_attachment  :pages,         :photo
    
    add_index       :pages,         :page_type
    add_index       :pages,         :page_url,     unique: true
  end
  
  def self.down
    remove_index    :pages,         :page_type
    remove_index    :pages,         :page_url
    remove_column   :pages,         :page_type
    remove_column   :pages,         :published_by
    remove_column   :pages,         :is_featured
    remove_attachment :pages,       :photo  
  end
end
