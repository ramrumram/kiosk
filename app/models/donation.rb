class Donation < ActiveRecord::Base
 belongs_to :church, :class_name => 'Church', :foreign_key => 'church_id'

end
