class AddMetaInfoToPages < ActiveRecord::Migration
  def self.up
    add_column        :pages,           :meta_description,        :text
    add_column        :pages,           :meta_title,              :string
  end

  def self.down
    remove_column        :pages,           :meta_description
    remove_column        :pages,           :meta_title
  end
end
