class Company < ApplicationRecord
  # before_save :check_address
  belongs_to :user
 
end
