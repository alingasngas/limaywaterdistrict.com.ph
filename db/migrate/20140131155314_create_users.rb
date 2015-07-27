class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
    	t.string			:first_name
    	t.string			:last_name
      t.string			:username
      t.string			:email
    	t.string 			:password_hash
    	t.string 			:password_salt
      t.integer 		:role_id
      t.string 			:gender,		:limit => 6
      t.text 				:address
      t.string 			:phone
      t.date				:birthdate
      t.boolean 		:status
      t.date 				:last_login_at
      t.string 			:last_ip

      t.timestamps
    end
    
    add_index(:users, [:first_name, :last_name, :email], :name => "user_info_index")
  end

  def self.down
    drop_table :users
  end
end