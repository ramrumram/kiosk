class Church < ActiveRecord::Base
 belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
 validates_uniqueness_of :title
  
 extend FriendlyId
 friendly_id :title, use: :slugged
 attr_accessor :mail_content,:email,:subject
 
 has_many :donations
  
  def should_generate_new_friendly_id?
        title_changed?
      end

 accepts_nested_attributes_for :donations

end
