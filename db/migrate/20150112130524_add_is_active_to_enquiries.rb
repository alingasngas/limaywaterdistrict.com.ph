class AddIsActiveToEnquiries < ActiveRecord::Migration
  def self.up
    add_column            :enquiries,         :is_active,         :boolean,       default: true
    add_column            :enquiries,         :is_replied,        :boolean,       default: false
    add_column            :enquiries,         :replied_by,        :integer
    add_column            :enquiries,         :replied_at,        :datetime

    add_index             :enquiries,         :is_active
    add_index             :enquiries,         :is_replied
  end

  def self.down

  end
end
