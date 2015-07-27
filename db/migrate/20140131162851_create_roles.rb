class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
    	t.string					:code,						:limit => 20
    	t.string					:name,						:limit => 100
    	t.boolean					:is_active,				:default => true
    	t.integer					:last_updated_by
    	
			t.timestamps
    end
    
    add_index(:roles,	[:code, :name], :name => "role_code_name_index")
  end
  
  def self.down
  	drop_table :roles
  end
end
