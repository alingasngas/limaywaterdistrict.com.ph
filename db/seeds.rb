# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
roles = Role.all
if roles.empty?
Role.create!([
        { :code => 'Adm',  :name => "Admin", :is_active => true},
        { :code => 'Ed',  :name => "Editor", :is_active => true}
      ])
end
admin_role = Role.find_by_name('Admin')
admin = User.find_by_username('admin')
if admin.nil?
admin = User.create!([{ :username => 'admin',  :first_name => "Admin", :last_name => "User", :email => 'user@example.com', :password => 'password1234', :password_confirmation => 'password1234', :role_id => admin_role.try(:id), :status => 1}])
end
homepage = Page.where(is_root: true).first
if homepage.nil?
homepage = Page.create!({:page_title => 'Home', :page_url => '/', :body => '<p>Lorem ipsum dolor sit amet</p>', :activate => true ,:is_root => true})
end
contactpage = Page.where(is_contact: true).first
if contactpage.nil?
contactpage = Page.create!({:page_title => 'Contact Us', :page_url => 'contact-us', :body => '', :activate => true ,:is_contact => true})
end

contact = Contact.first
if contact.nil?
  contact = Contact.create!({
                              :company_name => 'Inbox Business Solutions',
                              :street => 'Centro Uno',
                              :city => 'Orani',
                              :province => 'Bataan',
                              :country => 'PH',
                              :phone1 => '1111111',
                              :email => 'sample@email.com',
                              :business_hours_weekdays => 'Monday - Friday 8:00AM-5:00PM',
                              :business_hours_saturday => 'Closed',
                              :business_hours_sunday => 'Closed'
                            })
end
