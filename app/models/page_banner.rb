class PageBanner < ActiveRecord::Base
  belongs_to  :page
  belongs_to  :banner
end
