class AddIsFullPageToPages < ActiveRecord::Migration
  def self.up
    add_column          :pages,         :is_full_page,          :boolean,       default: false
  end

  def self.down
    remove_column       :pages,         :is_full_page
  end
end
