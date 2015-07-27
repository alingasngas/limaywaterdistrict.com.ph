class CreateRolePermissions < ActiveRecord::Migration
  def self.up
    create_table :role_permissions do |t|
    	t.integer				:role_id
    	t.integer				:user_permission_id

      t.timestamps
    end
  end
  
  def self.down
  	drop_table :role_permissions
  end
end
