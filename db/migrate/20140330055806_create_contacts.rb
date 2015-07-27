class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string      :company_name
      t.string      :address
      t.string      :phone1
      t.string      :phone2
      t.string      :fax
      t.string      :email
      t.string      :website
      t.string      :business_hours_weekdays
      t.string      :business_hours_saturday
      t.string      :business_hours_sunday
      t.float       :latitude
      t.float       :longitude


      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
