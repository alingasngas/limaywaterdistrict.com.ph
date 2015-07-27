class AddLogoToContactUs < ActiveRecord::Migration
  def self.up
    add_column    :contacts,      :logo_file_name,      :string
    add_column    :contacts,      :logo_content_type,   :string
    add_column    :contacts,      :logo_file_size,      :integer
    add_column    :contacts,      :last_updated_by,     :integer
  end

  def self.down
    remove_column    :contacts,      :logo_file_name
    remove_column    :contacts,      :logo_content_type
    remove_column    :contacts,      :logo_file_size
    remove_column    :contacts,      :last_updated_by
  end
end
