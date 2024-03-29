class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :companies
#   before_create :set_user_role   
  ROLES = %w{admin , customer }

  # ROLES.each do |role_name|
  #   define_method "#{role_name}?" do
  #     role == role_name
  #   end
  # end


   def admin?
    role == "admin"
   end

   def customer?
       role == "customer"
   end

end
