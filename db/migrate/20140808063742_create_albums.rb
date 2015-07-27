class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string              :title
      t.boolean           :is_active
      t.integer            :display_order
      t.integer            :last_updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
