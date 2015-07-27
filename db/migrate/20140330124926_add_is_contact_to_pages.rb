class AddIsContactToPages < ActiveRecord::Migration
  def self.up
    add_column  :pages, :is_contact, :boolean, :default => false
  end

  def self.down
    remove_column  :pages, :is_contact
  end
end
