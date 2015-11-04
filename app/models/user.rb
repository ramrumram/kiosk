class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable,:rememberable, :validatable 
    attr_accessor :login,:terms, :current_password

validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

has_one :church
accepts_nested_attributes_for(:church, update_only: true)

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions.to_h).first
      end
    end    
    
    
end
