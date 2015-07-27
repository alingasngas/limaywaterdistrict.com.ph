class AlterBannersTable < ActiveRecord::Migration

  def self.up
    remove_column   :banners,     :page_id
  end

  def self.down
    add_column      :banners,     :page_id,     :after => :featured
  end
end
