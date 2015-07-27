class AddRootToPages < ActiveRecord::Migration
  
  def self.up
    add_column    :pages,     :is_root,       :boolean, :default => false  
  end
  
  def self.down
    remove_column :pages, :is_root
  end
end
