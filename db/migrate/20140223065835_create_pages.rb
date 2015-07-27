class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string                  :page_title
      t.string                  :page_subtitle
      t.string                  :browser_title
      t.string                  :page_url
      t.text                    :body
      t.text                    :short_body
      t.string                  :link_forward
      t.integer                 :page_id
      t.integer                 :last_updated_by
      t.date                    :publish_date
      t.boolean                 :is_skip,         :default => false
      t.boolean                 :activate,        :default => false
      t.boolean                 :show_in_menu,    :default => false
      t.integer                 :display_order,   :default => 0
      t.text                    :page_scripts
      t.text                    :page_styles

      t.timestamps
    end
  end
  
  def self.down
    
    drop_table  :pages
    
  end
end
