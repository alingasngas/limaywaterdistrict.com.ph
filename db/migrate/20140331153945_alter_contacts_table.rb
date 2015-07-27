class AlterContactsTable < ActiveRecord::Migration
  def self.up
    remove_column     :contacts,      :address
    add_column        :contacts,      :street,        :string
    add_column        :contacts,      :city,          :string
    add_column        :contacts,      :province,      :string
    add_column        :contacts,      :country,       :string
  end

  def self.down
    add_column        :contacts,      :address,       :string
    remove_column     :contacts,      :street
    remove_column     :contacts,      :city
    remove_column     :contacts,      :province
    remove_column     :contacts,      :country
  end
end
